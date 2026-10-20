# Neovim

Neovim highlights with tree-sitter, not TextMate grammars, so it uses
[tree-sitter-agentica](https://github.com/agentica-lang/tree-sitter-agentica) instead of the grammar in this repository.
Its `queries/highlights.scm` uses the capture names of Neovim and nvim-treesitter. These steps were checked with Neovim
0.12, nvim-treesitter (`main` branch) and tree-sitter-cli 0.26.

## Filetype and highlighting

Neovim does not know `.agc`. Add this to `init.lua`:

```lua
vim.filetype.add({ extension = { agc = 'agentica' } })

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'agentica',
  callback = function() pcall(vim.treesitter.start) end,
})
```

Then install the parser and its queries in one of the two ways below. Until then, `.agc` files open without
highlighting; `pcall` keeps the missing parser from raising an error.

### With nvim-treesitter

This uses the API of nvim-treesitter's `main` branch; its frozen `master` branch registers parsers differently. Register
the parser in a `User TSUpdate` autocommand, then run `:TSInstall agentica`. nvim-treesitter needs `curl`, `tar`, a C
compiler and tree-sitter-cli to build it. `branch = 'master'` below is the branch of tree-sitter-agentica.

```lua
vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter.parsers').agentica = {
      install_info = {
        url = 'https://github.com/agentica-lang/tree-sitter-agentica',
        branch = 'master',
        queries = 'queries',
      },
    }
  end,
})
```

### Without nvim-treesitter

This needs `git`, a C compiler and tree-sitter-cli. Build the parser and copy the queries to the `site` directory of
Neovim's data path (Linux and macOS shown; on Windows the parser is `parser/agentica.dll`):

```sh
git clone https://github.com/agentica-lang/tree-sitter-agentica
cd tree-sitter-agentica
site="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site"
mkdir -p "$site/parser" "$site/queries/agentica"
tree-sitter build -o "$site/parser/agentica.so"
cp queries/*.scm "$site/queries/agentica/"
```

To update, run `git pull` in the clone, then repeat the `tree-sitter build` and `cp` lines.

## Diagnostics

[agc-lsp](https://github.com/agentica-lang/agc-lsp) reports the first diagnostic of `agentica check` for the file on
disk. It needs `agentica` 0.5.0 or later on `PATH`. With a checkout of agc-lsp:

```lua
vim.lsp.config('agc_lsp', {
  cmd = { 'agentica', '--allow-run', '/path/to/agc-lsp/src/main.agc' },
  filetypes = { 'agentica' },
  root_markers = { '.git' },
})
vim.lsp.enable('agc_lsp')
```
