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
  callback = function() vim.treesitter.start() end,
})
```

Then install the parser and its queries in one of the two ways below.

### With nvim-treesitter

Register the parser in a `User TSUpdate` autocommand, then run `:TSInstall agentica`. nvim-treesitter needs `curl`,
`tar`, a C compiler and tree-sitter-cli to build it.

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

Build the parser with tree-sitter-cli and copy the queries to the `site` directory of Neovim's data path:

```sh
git clone https://github.com/agentica-lang/tree-sitter-agentica
cd tree-sitter-agentica
site="${XDG_DATA_HOME:-$HOME/.local/share}/nvim/site"
mkdir -p "$site/parser" "$site/queries/agentica"
tree-sitter build -o "$site/parser/agentica.so"
cp queries/*.scm "$site/queries/agentica/"
```

Repeat these steps to update the parser.

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
