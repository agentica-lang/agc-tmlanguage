import assert from "node:assert/strict";
import { readFileSync } from "node:fs";
import { createRequire } from "node:module";
import { dirname, join, resolve } from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";
import oniguruma from "vscode-oniguruma";
import textmate from "vscode-textmate";

// The .agc files assert scopes per column; these tests cover what a test line cannot hold: the exact text of a
// token, a CRLF file, and a file whose last line has no newline.

const require = createRequire(import.meta.url);
const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const grammarPath = join(root, "syntaxes", "agentica.tmLanguage.json");
const PRIVATE = "keyword.control.private.agentica";
const COMMENT = "comment.line.number-sign.agentica";

const wasm = readFileSync(require.resolve("vscode-oniguruma/release/onig.wasm"));
await oniguruma.loadWASM(wasm.buffer.slice(wasm.byteOffset, wasm.byteOffset + wasm.byteLength));
const grammar = await new textmate.Registry({
  onigLib: Promise.resolve({
    createOnigScanner: (patterns) => new oniguruma.OnigScanner(patterns),
    createOnigString: (text) => new oniguruma.OnigString(text),
  }),
  loadGrammar: async () => textmate.parseRawGrammar(readFileSync(grammarPath, "utf8"), grammarPath),
}).loadGrammar("source.agentica");

// Tokenizes `text` line by line. `keepCr` leaves the "\r" of a CRLF line in the line, as a tool that splits on "\n"
// only does; an editor strips it, which is `keepCr: false`. Returns the tokens of every line as [text, scopes].
function tokenize(text, { keepCr }) {
  let stack = textmate.INITIAL;
  return text.split(keepCr ? "\n" : /\r?\n/).map((line) => {
    const result = grammar.tokenizeLine(line, stack);
    stack = result.ruleStack;
    return result.tokens.map((t) => [line.slice(t.startIndex, t.endIndex), t.scopes]);
  });
}

const withScope = (tokens, scope) => tokens.filter(([, scopes]) => scopes.includes(scope)).map(([text]) => text);
// The text of a run of tokens with one scope, such as a comment that the grammar splits at its `#`.
const textOf = (tokens, scope) => withScope(tokens, scope).join("");

// The words of `lines[index]` that have the private scope: [] when the line is no marker, ["private"] when it is.
function marker(lines, index) {
  return withScope(lines[index], PRIVATE);
}

const FILE = "LIMIT = 1\n\nprivate\n\nBUFFER = 2\n";
const MODULE = "module M\n  private\n\n  def f() -> Int = 1\n\n  private\nend\n";
const STRUCT = "struct S\n  private\n  a: Int\n  private # c\nend\n";

for (const eol of ["\n", "\r\n"]) {
  for (const keepCr of eol === "\r\n" ? [false, true] : [false]) {
    const name = `${eol === "\n" ? "LF" : "CRLF"}${keepCr ? " with the CR kept" : ""}`;

    test(`the private line has exactly the word in its scope: ${name}`, () => {
      const file = tokenize(FILE.replaceAll("\n", eol), { keepCr });
      assert.deepEqual(marker(file, 2), ["private"]);
      assert.deepEqual(marker(file, 0), []);
      assert.deepEqual(marker(file, 4), []);

      const mod = tokenize(MODULE.replaceAll("\n", eol), { keepCr });
      assert.deepEqual(marker(mod, 1), ["private"], "first line of the block");
      assert.deepEqual(marker(mod, 5), ["private"], "last line of the block");

      const struct = tokenize(STRUCT.replaceAll("\n", eol), { keepCr });
      assert.deepEqual(marker(struct, 1), ["private"], "first line of the struct");
      assert.deepEqual(marker(struct, 3), ["private"]);
      assert.equal(textOf(struct[3], COMMENT).trimEnd(), "# c");
    });
  }
}

test("the private line is the last line of a file with no newline", () => {
  for (const text of ["def f() -> Int = 1\n\nprivate", "private", "private # last"]) {
    const lines = tokenize(text, { keepCr: false });
    assert.deepEqual(marker(lines, lines.length - 1), ["private"], JSON.stringify(text));
  }
});

test("blanks, a tab or a comment after private keep the marker and a comment scope", () => {
  const cases = [
    ["private ", null],
    ["private\t", null],
    ["private \t ", null],
    ["private# glued", "# glued"],
    ["private # helpers", "# helpers"],
    ["private\t# after a tab", "# after a tab"],
    ["private\r", null],
    ["private # note\r", "# note\r"],
  ];
  for (const [line, comment] of cases) {
    const [tokens] = tokenize(line, { keepCr: true });
    assert.deepEqual(withScope(tokens, PRIVATE), ["private"], JSON.stringify(line));
    assert.equal(textOf(tokens, COMMENT), comment ?? "", JSON.stringify(line));
  }
});

test("private is a name when anything else is on the line", () => {
  const names = [
    "private = 1",
    "private()",
    "private?",
    "private!",
    "private.size",
    "private_key",
    "privately",
    "x = private",
    "f(private: 1)",
    "m = {private: 2}",
    "x.private",
    "def private() -> Int = 1",
    'u = "#{private}"',
    'u = "private"',
    "# private",
    "private + 1",
    "private do",
  ];
  for (const line of names) {
    const [tokens] = tokenize(line, { keepCr: false });
    assert.deepEqual(withScope(tokens, PRIVATE), [], line);
  }
});

test("a lone private in a function body is a name, in a file and in a module block", () => {
  const body = tokenize("def f(private: Bool) -> Bool\n  private\nend\n", { keepCr: false });
  assert.deepEqual(marker(body, 1), []);
  const inModule = tokenize("module M\n  def f(private: Bool) -> Bool\n    private\n  end\nend\n", { keepCr: false });
  assert.deepEqual(marker(inModule, 2), []);
});

test("a module block ends at its own end, so what follows is outside it", () => {
  const lines = tokenize("module M\n  def f() -> Int = 1\nend\n\n  private\n", { keepCr: false });
  assert.deepEqual(marker(lines, 4), [], "an indented private after the block is not a module marker");
  assert.ok(lines[2].every(([, scopes]) => scopes.includes("meta.module.agentica")));
  assert.ok(lines[4].every(([, scopes]) => !scopes.includes("meta.module.agentica")));
});
