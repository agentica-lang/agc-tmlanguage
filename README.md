# agc-tmlanguage

A TextMate grammar (syntax highlighting) for [Agentica](https://github.com/sonic182/agentica), a language for AI agents.
Tracked in [sonic182/agentica#347](https://github.com/sonic182/agentica/issues/347).

> **Status:** early stage. The grammar and a VS Code extension are usable; nothing is published yet.

The grammar is [`syntaxes/agentica.tmLanguage.json`](syntaxes/agentica.tmLanguage.json), with scope name
`source.agentica` for `.agc` files. It is tested with vscode-textmate, the engine of VS Code and Shiki. Sublime Text
and `bat` read `.sublime-syntax` files, so they need a converted copy.

## VS Code

The repository is also a VS Code extension: the grammar plus a language configuration (`#` comments, bracket pairs,
indentation after `def`, `if`, `do` and the other block openers, and words that keep a `?` or `!` suffix). It is not on
a marketplace yet; build and install it from a checkout:

```sh
npm ci
npm run package                 # writes agentica-0.1.0.vsix
code --install-extension agentica-0.1.0.vsix
```

The indentation rules are line patterns. Enter after a case arm's `->` indents the body, but nothing outdents the next
arm; lines inside a heredoc body count like code.

## Development

```sh
npm ci
npm test                        # grammar assertions in test/*.agc and the extension test
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
- `Models.User` in a type position scopes `User` as an enum variant, as `Color.Red` does.
- An all-caps name such as `TIMEOUT_MS` is scoped as a constant, so an all-caps type name (`URL`) is too.

## License

Licensed under the [Apache License 2.0](LICENSE).
