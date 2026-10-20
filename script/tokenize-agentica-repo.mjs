import { existsSync, readFileSync, readdirSync, statSync } from "node:fs";
import { createRequire } from "node:module";
import { homedir } from "node:os";
import { dirname, join, relative, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import oniguruma from "vscode-oniguruma";
import textmate from "vscode-textmate";

const require = createRequire(import.meta.url);
const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const grammarPath = join(root, "syntaxes", "agentica.tmLanguage.json");

export async function loadGrammar() {
  const wasm = readFileSync(require.resolve("vscode-oniguruma/release/onig.wasm"));
  await oniguruma.loadWASM(wasm.buffer.slice(wasm.byteOffset, wasm.byteOffset + wasm.byteLength));
  const registry = new textmate.Registry({
    onigLib: Promise.resolve({
      createOnigScanner: (patterns) => new oniguruma.OnigScanner(patterns),
      createOnigString: (text) => new oniguruma.OnigString(text),
    }),
    loadGrammar: async (scopeName) =>
      scopeName === "source.agentica"
        ? textmate.parseRawGrammar(readFileSync(grammarPath, "utf8"), grammarPath)
        : null,
  });
  return registry.loadGrammar("source.agentica");
}

export function tokenize(grammar, text) {
  let stack = textmate.INITIAL;
  const lines = text.replace(/\r\n?/g, "\n").replace(/\n$/, "").split("\n");
  const result = [];
  for (const line of lines) {
    const { tokens, ruleStack } = grammar.tokenizeLine(line, stack);
    result.push({ line, tokens });
    stack = ruleStack;
  }
  return { lines: result, depth: stack.depth };
}

function walk(dir, keep) {
  if (!existsSync(dir)) return [];
  return readdirSync(dir).sort().flatMap((name) => {
    const path = join(dir, name);
    if (statSync(path).isDirectory()) return walk(path, keep);
    return keep(path) ? [path] : [];
  });
}

function firstLine(path) {
  return readFileSync(path, "utf8").split("\n", 1)[0];
}

function intentionallyInvalid(repo) {
  const fixtures = join(repo, "tests", "fixtures");
  const invalid = new Set([join(fixtures, "frontend/modules/std-queue-embedded/std/queue.agc")]);
  const goldens = (ext) => walk(fixtures, (path) => path.endsWith(ext));
  for (const golden of goldens(".expected")) {
    if (/^ERROR (LEX-|PARSE-(?!GHERKIN-))/.test(firstLine(golden))) {
      invalid.add(`${golden.slice(0, -".expected".length)}.agc`);
    }
  }
  for (const golden of goldens(".linked")) {
    const file = firstLine(golden).match(/^ERROR (?:LEX-|PARSE-).* file="([^"]+)"/)?.[1];
    if (file) invalid.add(join(golden.slice(0, -".linked".length), file));
  }
  return invalid;
}

function siteBlocks(repo) {
  const pages = walk(join(repo, "site", "content"), (path) => path.endsWith(".md"));
  return pages.flatMap((page) => {
    const blocks = [];
    let block = null;
    readFileSync(page, "utf8").split("\n").forEach((line, index) => {
      if (block === null && /^```agentica(\s|$)/.test(line)) {
        block = { name: `${page}:${index + 1}`, skip: /expect="(LEX|PARSE)-/.test(line), lines: [] };
      } else if (block !== null && line.startsWith("```")) {
        if (!block.skip) blocks.push({ name: block.name, text: block.lines.join("\n") });
        block = null;
      } else if (block !== null) {
        block.lines.push(line);
      }
    });
    return blocks;
  });
}

async function main() {
  const repo = resolve(process.argv[2] ?? process.env.AGENTICA_REPO ?? join(homedir(), "apps", "agentica"));
  if (!existsSync(join(repo, "examples"))) {
    console.error(`not an Agentica checkout: ${repo}`);
    process.exit(2);
  }
  const grammar = await loadGrammar();
  const invalid = intentionallyInvalid(repo);
  const dirs = ["examples", "stdlib", "tests/fixtures", "tests/bdd"].map((dir) => join(repo, dir));
  const sources = dirs
    .flatMap((dir) => walk(dir, (path) => path.endsWith(".agc")))
    .filter((path) => !invalid.has(path))
    .map((path) => ({ name: relative(repo, path), text: readFileSync(path, "utf8") }))
    .concat(siteBlocks(repo).map((block) => ({ ...block, name: relative(repo, block.name) })));
  const failures = sources.filter((source) => tokenize(grammar, source.text).depth !== 1);
  for (const source of failures) console.error(`unclosed rule at end of source: ${source.name}`);
  console.log(`${sources.length - failures.length}/${sources.length} sources end at the root rule`);
  process.exit(failures.length === 0 ? 0 : 1);
}

if (process.argv[1] === fileURLToPath(import.meta.url)) {
  await main();
}
