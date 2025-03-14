# Enhanced Neovim Configuration

A beautiful and feature-rich Neovim configuration with excellent UX and modern features.

## Features

- 🎨 **Beautiful UI**: Modern and clean interface with carefully selected themes and UI components
- ⚡ **Fast and Efficient**: Lazy-loaded plugins for quick startup times
- 🧠 **Smart Code Editing**: Intelligent code completion, navigation, and editing features
- 🔍 **Powerful Search**: Fuzzy finding for files, text, and more
- 🌳 **File Navigation**: Intuitive file explorer and buffer management
- 🖥️ **Terminal Integration**: Seamless terminal experience within Neovim
- 📦 **Plugin Management**: Easy plugin management with lazy.nvim
- 🔧 **Customizable**: Well-organized configuration files for easy customization

## UI Enhancements

- **Dashboard**: Beautiful start screen with quick actions
- **Statusline**: Informative and customizable status line
- **Bufferline**: Tab/buffer line with close buttons and indicators
- **Indent Guides**: Visual guides for code indentation
- **Notifications**: Modern notification system
- **Command Line**: Enhanced command line interface
- **Scrollbar**: Visual scrollbar with diagnostic indicators
- **Colorschemes**: Multiple beautiful themes with easy switching

## Navigation Features

- **Smart Window Management**: Intelligent window navigation and resizing
- **Window Animations**: Smooth window animations for better visual feedback
- **Terminal Integration**: Floating and split terminal windows
- **Session Management**: Save and restore your workspace
- **Tab Management**: Better tab management with scope.nvim

## Coding Features

- **Treesitter**: Advanced syntax highlighting and code navigation
- **LSP**: Language Server Protocol for intelligent code features
- **Auto Pairs**: Automatically close brackets, quotes, etc.
- **Surround**: Easily surround text with brackets, quotes, etc.
- **Comments**: Smart commenting with context awareness
- **Git Integration**: Git signs and actions in the editor
- **Code Folding**: Better code folding with preview
- **Todo Comments**: Highlight and search for TODO comments
- **Colorizer**: Highlight color codes with their actual colors

## Keymaps

### General

- `<Space>` - Leader key
- `<leader>e` - Toggle file explorer
- `<leader>ff` - Find files
- `<leader>fg` - Live grep
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help tags
- `<leader>cs` - Switch colorscheme

### Windows and Tabs

- `<C-h/j/k/l>` - Navigate between windows
- `<A-h/j/k/l>` - Resize windows
- `<leader>wm` - Maximize window
- `<leader>we` - Equalize windows
- `<leader>wp` - Pick a window
- `<leader>1-9` - Go to buffer 1-9

### Terminal

- `<C-\>` - Toggle floating terminal
- `<leader>tt` - Toggle floating terminal
- `<leader>th` - Toggle horizontal terminal
- `<leader>tv` - Toggle vertical terminal
- `<leader>tg` - Toggle Lazygit

### Code Editing

- `gcc` - Comment line
- `gc` - Comment with motion
- `ys` - Add surrounding
- `cs` - Change surrounding
- `ds` - Delete surrounding
- `zR` - Open all folds
- `zM` - Close all folds
- `zp` - Peek folded code

### Git

- `]c` / `[c` - Next/previous git hunk
- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hb` - Blame line
- `<leader>hp` - Preview hunk

### Focus Mode

- `<leader>zz` - Toggle Zen mode
- `<leader>tw` - Toggle Twilight (dim inactive code)

## Installation

1. Backup your existing Neovim configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.bak
   ```

2. Clone this repository:
   ```bash
   git clone https://github.com/parsilver/nvim-config.git ~/.config/nvim
   ```

3. Start Neovim:
   ```bash
   nvim
   ```

4. Wait for plugins to install automatically.

## Requirements

- Neovim >= 0.9.0
- Git
- A [Nerd Font](https://www.nerdfonts.com/) for icons
- (Optional) [ripgrep](https://github.com/BurntSushi/ripgrep) for better search
- (Optional) [fd](https://github.com/sharkdp/fd) for faster file finding
- (Optional) [lazygit](https://github.com/jesseduffield/lazygit) for Git integration

## Structure

```
~/.config/nvim/
├── init.lua                 # Main entry point
├── lua/
│   ├── core/                # Core configuration
│   │   ├── options.lua      # Neovim options
│   │   ├── keymaps.lua      # Key mappings
│   │   ├── plugins.lua      # Plugin management
│   │   └── colorscheme.lua  # Colorscheme settings
│   └── plugins/             # Plugin configurations
│       ├── ui-enhancements.lua  # UI plugins
│       ├── navigation.lua       # Navigation plugins
│       ├── coding.lua           # Coding plugins
│       ├── colorscheme.lua      # Colorscheme plugins
│       └── ...                  # Other plugin configs
└── README.md                # Documentation
```

## Customization

- Edit `lua/core/options.lua` to change Neovim options
- Edit `lua/core/keymaps.lua` to change key mappings
- Edit `lua/plugins/` files to configure or add plugins

## Credits

This configuration is inspired by and borrows from:

- [LazyVim](https://github.com/LazyVim/LazyVim)
- [NvChad](https://github.com/NvChad/NvChad)
- [LunarVim](https://github.com/LunarVim/LunarVim)
- [AstroNvim](https://github.com/AstroNvim/AstroNvim)

## License

MIT 
