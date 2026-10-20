# agc-tmlanguage

A TextMate grammar (syntax highlighting) for [Agentica](https://github.com/sonic182/agentica), a language for AI agents.
Tracked in [sonic182/agentica#347](https://github.com/sonic182/agentica/issues/347).

> **Status:** early stage. The grammar is usable; editor packaging is not done yet.

The grammar is [`syntaxes/agentica.tmLanguage.json`](syntaxes/agentica.tmLanguage.json), with scope name
`source.agentica` for `.agc` files. Any TextMate-compatible highlighter can load it (VS Code, Shiki, Sublime Text, `bat`).

## Development

```sh
npm ci
npm test                        # assertion tests in test/*.agc
npm run test:repo -- [path]     # tokenize every source of an Agentica checkout
```

`test/*.agc` are [vscode-tmgrammar-test](https://github.com/PanAeon/vscode-tmgrammar-test) files: a `# ^^^ scope`
comment line asserts the scopes of the characters above its carets.

`test:repo` tokenizes every `.agc` file in `examples/`, `stdlib/`, `tests/fixtures/` and `tests/bdd/` of the
[Agentica repository](https://github.com/sonic182/agentica), and every `agentica` code block in `site/content/`. It
fails when a source ends inside an open rule, such as an unterminated heredoc. The path defaults to `~/apps/agentica`;
`AGENTICA_REPO` also sets it. Fixtures that are invalid on purpose (a `LEX-` or `PARSE-` golden) are skipped.

## Known limitations

A TextMate grammar matches lines with regular expressions, so it approximates the language:

- Only one or two heredocs may open on the same line.
- A map key written as a bare name (`{a: 1}`) is scoped like a named argument.
- `Models.User` in a type position scopes `User` as an enum variant, as `Color.Red` does.

## License

Licensed under the [Apache License 2.0](LICENSE).
