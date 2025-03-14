# Neovim Configuration

A modern, feature-rich Neovim configuration with LSP support, autocompletion, and a beautiful UI.

## Features

- 🚀 Fast startup with lazy loading plugins
- 🎨 Beautiful UI with Tokyo Night theme
- 🔍 Fuzzy finding with Telescope
- 🌳 File explorer with nvim-tree
- 📝 LSP support for code intelligence
- ✨ Autocompletion with nvim-cmp
- 🔧 Formatting and linting
- 📦 Git integration with gitsigns
- 🔤 Syntax highlighting with Treesitter
- 🔑 Which-key for keybinding help

## Key Mappings

The leader key is set to `<Space>`.

For a complete list of all keymaps, including information about intentionally overlapping keymaps, see [KEYMAPS.md](./KEYMAPS.md).

### General

- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>wq` - Save and quit
- `jk` - Exit insert mode

### Navigation

- `<C-h/j/k/l>` - Navigate between windows
- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<leader>se` - Make splits equal size
- `<leader>sx` - Close current split

### File Explorer

- `<leader>e` - Toggle file explorer
- `<leader>ef` - Find current file in explorer

### Telescope (Fuzzy Finder)

- `<leader>ff` - Find files
- `<leader>fg` - Find text (grep)
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help
- `<leader>fr` - Find recent files

### LSP

- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Find references
- `K` - Show hover documentation
- `<leader>lr` - Rename symbol
- `<leader>la` - Code action
- `<leader>lf` - Format code
- `[d` / `]d` - Previous/next diagnostic

### Git

- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hb` - Blame line
- `<leader>hd` - Diff this
- `]c` / `[c` - Next/previous hunk

## Installation

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management, which will automatically install all plugins on first startup.

### Prerequisites

- Neovim >= 0.9.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- Node.js (for LSP servers)
- ripgrep (for Telescope grep)

### First Run

On first run, lazy.nvim will install all plugins and language servers will be installed via Mason.

## Customization

- Edit `lua/core/options.lua` to change Neovim options
- Edit `lua/core/keymaps.lua` to change key mappings
- Edit `lua/core/colorscheme.lua` to change the colorscheme
- Add new plugins in the `lua/plugins/` directory

## Troubleshooting

If you encounter any issues:

1. Run `:checkhealth` to diagnose problems
2. Update plugins with `:Lazy update`
3. Update LSP servers with `:Mason` 