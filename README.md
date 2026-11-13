# agc-tmlanguage

A TextMate grammar (syntax highlighting) for [Agentica](https://github.com/sonic182/agentica), a language for AI agents.
Tracked in [sonic182/agentica#347](https://github.com/sonic182/agentica/issues/347).

> **Status:** early stage. The grammar and a VS Code extension are usable; nothing is published yet.

The grammar is [`syntaxes/agentica.tmLanguage.json`](syntaxes/agentica.tmLanguage.json), with scope name
`source.agentica` for `.agc` files. It is tested with vscode-textmate, the engine of VS Code and Shiki. Sublime Text
and `bat` read `.sublime-syntax` files, so they need a converted copy.

Neovim highlights with tree-sitter instead; see [docs/neovim.md](docs/neovim.md) for its setup.

## VS Code

The repository is also a VS Code extension: the grammar plus a language configuration (`#` comments, bracket pairs,
indentation after `def`, `if`, `do`, the other block openers and the `) -> Type` line that closes a multi-line `def`
header, and words that keep a `?` or `!` suffix). It is not on a marketplace yet; build and install it from a checkout:

```sh
npm ci
npm run package                 # writes agentica-0.3.0.vsix
code --install-extension agentica-0.3.0.vsix
```

CI also uploads the `.vsix` of each run as the `agentica-vsix` artifact.

The indentation rules are line patterns. Enter after a case arm's `->` indents the body, but nothing outdents the next
arm; lines inside a heredoc body count like code.

### Publishing

The manual `Publish` workflow (Actions > Publish > Run workflow, from `main` only) runs the tests, builds the `.vsix`
and publishes it to the VS Code Marketplace, Open VSX or both. It needs these repository secrets and fails before
building if the chosen target's secret is missing:

- `VSCE_PAT`: an Azure DevOps personal access token with the Marketplace > Manage scope, for the `agentica-lang`
  publisher.
- `OVSX_PAT`: an Open VSX access token. Create the `agentica-lang` namespace once with `npx ovsx create-namespace
  agentica-lang --pat <token>`.

Bump `version` in `package.json` before publishing a new release. A target that already has that version is skipped, so
after a partial failure the workflow can be run again with `both`.

## Development

The dev dependencies need Node 22 or later; CI uses Node 24.

```sh
npm ci
npm test                        # grammar assertions in test/*.agc, the token tests and the extension test
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

- A call without `()` before a block (`run do ... end`, `twice { |x| x + 1 }`) is scoped as a function only at a statement
  start or after `=`, `(`, `,` or `|>`; elsewhere it stays a variable.
- `Family.Member` (`HTTP.Request`, `OpenSSL.Digest`) is scoped by shape: both names are types, as in any type path, and a call on a capitalized name (`Logger.info(x)`) is a module call. The grammar has no list of builtin names, so a user's names color the same way.
- Only one or two heredocs may open on the same line. When two do, a line of the second body that starts at column 0
  with `<<~NAME` opens a new heredoc.
- A map key written as a bare name (`{a: 1}`) is scoped like a named argument (`f(a, name: value)`).
- The `private` line (`keyword.control.private`) is the word alone on its line, with blanks or a `#` comment after it;
  anywhere else `private` is a name. The grammar finds the line by its place: in column 0 of a file, at two spaces (or a
  tab) inside a `module` block, which it follows to the `end` at the indent of its `module` line, and at any indent in a
  struct body. So a lone `private` that ends a function body (a variable) is a name, but a module body indented by
  another width than `agentica fmt` writes reads its `private` line as a name too.
- A `module` rule ends only at an `end` with the indent of its `module` line. Agentica accepts a module whose `end` is
  indented; the module scope then runs on to the next `end` at the indent of the `module` line, and a lone `private`
  in the next function reads as the keyword. `agentica fmt` rewrites such a file.
- `export` is a keyword only in a re-export (`export Alias.name`). Before a declaration, which Agentica 0.31 rejects, it
  is scoped `invalid.illegal.export` and the declaration is highlighted as usual.
- Outside `def` headers, type aliases and typed bindings (`x: Models.User = ...`), `Models.User` scopes `User` as an enum
  variant, as `Color.Red` does: in an expression the two look the same.
- An all-caps name such as `TIMEOUT_MS` is scoped as a constant, so an all-caps type name (`URL`) is too.
- A `/` starts a regex literal (`string.regexp`) at a line start, right after `= ( [ { , | & < > :` or a `!` that
  follows no name character, after one of those or `+ - * %` and a space, or after a keyword such as `return`, `and`
  or `if` and a space; anywhere else it is division. The language decides by the token before the `/`, which a line
  pattern cannot always see:
  - the grammar sees at most one space before the `/`, so `x =  /a/` (two spaces) is scoped as division;
  - inside `(`, `[` and `{` the language drops line breaks, so a line that starts with `/` there is division after
    the value on the line before, while the grammar scopes a regex.

  A regex that does not close on its line ends there.

## License

Licensed under the [Apache License 2.0](LICENSE).
