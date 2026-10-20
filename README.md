# agc-tmlanguage

A TextMate grammar (syntax highlighting) for [Agentica](https://github.com/sonic182/agentica), a language for AI agents.
Tracked in [sonic182/agentica#347](https://github.com/sonic182/agentica/issues/347).

> **Status:** early stage. The grammar is usable; editor packaging is not done yet.

The grammar is [`syntaxes/agentica.tmLanguage.json`](syntaxes/agentica.tmLanguage.json), with scope name
`source.agentica` for `.agc` files. It is tested with vscode-textmate, the engine of VS Code and Shiki. Sublime Text
and `bat` read `.sublime-syntax` files, so they need a converted copy.

Neovim highlights with tree-sitter instead; see [docs/neovim.md](docs/neovim.md) for its setup.

## Development

```sh
npm ci
npm test                        # assertion tests in test/*.agc
npm run test:repo -- [path]     # tokenize every source of an Agentica checkout
```

`test/*.agc` are [vscode-tmgrammar-test](https://github.com/PanAeon/vscode-tmgrammar-test) files: a `# ^^^ scope`
comment line asserts the scopes of the characters above its carets.

`test:repo` tokenizes every `.agc` file in `compiler/`, `examples/`, `stdlib/`, `tests/fixtures/` and `tests/bdd/` of the
[Agentica repository](https://github.com/sonic182/agentica), and every `agentica` code block in `site/content/`. It
fails when a source ends inside an open rule, such as an unterminated heredoc, or when a rule is still open at a
top-level `def`, `struct`, `enum` or `type` line. The path defaults to `../agentica`;
`AGENTICA_REPO` also sets it. CI checks a pinned Agentica commit (`ref` in
`.github/workflows/ci.yml`); bump it on purpose. Fixtures that are invalid on purpose (a `LEX-` or `PARSE-` golden) are skipped.

## Known limitations

A TextMate grammar matches lines with regular expressions, so it approximates the language:

- Only one or two heredocs may open on the same line. When two do, a line of the second body that starts at column 0
  with `<<~NAME` opens a new heredoc.
- A map key written as a bare name (`{a: 1}`) is scoped like a named argument.
- Outside `def` headers, type aliases and typed bindings (`x: Models.User = ...`), `Models.User` scopes `User` as an enum
  variant, as `Color.Red` does: in an expression the two look the same.
- An all-caps name such as `TIMEOUT_MS` is scoped as a constant, so an all-caps type name (`URL`) is too.

## License

Licensed under the [Apache License 2.0](LICENSE).
