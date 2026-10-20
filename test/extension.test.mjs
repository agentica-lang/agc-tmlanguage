import assert from "node:assert/strict";
import { existsSync, readFileSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { test } from "node:test";
import { fileURLToPath } from "node:url";

const root = resolve(dirname(fileURLToPath(import.meta.url)), "..");
const readJson = (path) => JSON.parse(readFileSync(join(root, path), "utf8"));
const manifest = readJson("package.json");
const [language] = manifest.contributes.languages;
const [grammar] = manifest.contributes.grammars;
const config = readJson(language.configuration);

test("the manifest points at the grammar and the language configuration", () => {
  assert.equal(language.id, "agentica");
  assert.deepEqual(language.extensions, [".agc"]);
  assert.equal(grammar.language, language.id);
  assert.ok(existsSync(join(root, language.configuration)));
  assert.ok(existsSync(join(root, grammar.path)));
  assert.equal(readJson(grammar.path).scopeName, grammar.scopeName);
});

test("line comments use #", () => {
  assert.equal(config.comments.lineComment, "#");
});

test("words keep the ? and ! suffix", () => {
  const word = new RegExp(config.wordPattern, "g");
  assert.deepEqual("done? = gets!() + Item.size(1_000.5)".match(word), ["done?", "gets!", "Item", "size", "1_000.5"]);
});

test("indentation follows blocks", () => {
  const increase = new RegExp(config.indentationRules.increaseIndentPattern);
  const decrease = new RegExp(config.indentationRules.decreaseIndentPattern);
  const opens = [
    "def area(shape: Shape) -> Float",
    "export def run() -> Void",
    "struct Point",
    "enum Shape[T]",
    "  if total > 10",
    "  elsif ready?",
    "  else",
    "  while xs.any? do",
    "  for x in xs do",
    "  case shape",
    "  xs.map do |item|",
    "  ys.each do # comment",
  ];
  const stays = [
    "  total = p.x + 1",
    "  xs.map do |item| item * 2 end",
    "  # do",
    "  if ready? then_value end",
    "  done = 1",
    "  endpoint = 2",
  ];
  for (const line of opens) assert.ok(increase.test(line), `should indent after: ${line}`);
  for (const line of stays) assert.ok(!increase.test(line), `should not indent after: ${line}`);
  for (const line of ["end", "  end", "  elsif x", "  else"]) assert.ok(decrease.test(line), `should outdent: ${line}`);
  for (const line of ["  endpoint = 2", "  ending()", "  elsewhere = 1"]) {
    assert.ok(!decrease.test(line), `should not outdent: ${line}`);
  }
});
