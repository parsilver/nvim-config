# Fixing Markdown Preview in Neovim

If you're encountering the error `Vim:E117: Unknown function: mkdp#util#install` when trying to use the markdown-preview.nvim plugin, here are several solutions to try:

## Solution 1: Manual Installation (RECOMMENDED)

I've already manually installed the dependencies for you. The plugin should now work correctly. Try using the markdown preview commands:

- `<leader>mp` - Start markdown preview
- `<leader>ms` - Stop markdown preview
- `<leader>mt` - Toggle markdown preview

If it still doesn't work, you can try reinstalling the dependencies manually:

1. Navigate to your Neovim plugins directory:
   ```bash
   cd ~/.local/share/nvim/lazy/markdown-preview.nvim
   ```

2. Install the dependencies manually:
   ```bash
   cd app && npm install
   ```

3. Restart Neovim and try using the markdown preview commands again.

## Solution 2: Use Alternative Configuration

I've provided three different configuration files for the markdown-preview.nvim plugin:

1. **Main configuration** (lua/plugins/markdown-preview.lua):
   - Uses `cd app && npm install && git restore .` as the build command

2. **Alternative configuration** (lua/plugins/markdown-preview-alt.lua):
   - Uses the `vim.fn["mkdp#util#install"]()` function in a different way

3. **Yarn-based configuration** (lua/plugins/markdown-preview-yarn.lua):
   - Uses `cd app && yarn install` as the build command

To use one of the alternative configurations:

1. Rename the current markdown-preview.lua file:
   ```bash
   mv ~/.config/nvim/lua/plugins/markdown-preview.lua ~/.config/nvim/lua/plugins/markdown-preview.lua.bak
   ```

2. Rename one of the alternative configurations to markdown-preview.lua:
   ```bash
   # For the alternative configuration:
   mv ~/.config/nvim/lua/plugins/markdown-preview-alt.lua ~/.config/nvim/lua/plugins/markdown-preview.lua
   
   # OR for the yarn-based configuration:
   mv ~/.config/nvim/lua/plugins/markdown-preview-yarn.lua ~/.config/nvim/lua/plugins/markdown-preview.lua
   ```

3. Restart Neovim and run `:Lazy sync` to reinstall the plugin.

## Solution 3: Use Glow.nvim Instead

If you're still having issues with markdown-preview.nvim, I've provided an alternative plugin called glow.nvim that you can use instead:

1. Disable the markdown-preview.nvim plugin:
   ```bash
   mv ~/.config/nvim/lua/plugins/markdown-preview.lua ~/.config/nvim/lua/plugins/markdown-preview.lua.disabled
   ```

2. Enable the glow.nvim plugin:
   ```bash
   # Make sure the file is named correctly
   mv ~/.config/nvim/lua/plugins/glow-markdown.lua ~/.config/nvim/lua/plugins/glow-markdown.lua
   ```

3. Restart Neovim and run `:Lazy sync` to install the glow.nvim plugin.

4. Use the `<leader>mp` keymap to preview markdown files with Glow.

Note: The glow.nvim plugin requires the `glow` binary to be installed on your system. You can install it with:

```bash
# macOS
brew install glow

# Linux
sudo snap install glow
```

## Keymaps

Once the plugin is working, you can use these keymaps in markdown files:

- `<leader>mp` - Start markdown preview
- `<leader>ms` - Stop markdown preview
- `<leader>mt` - Toggle markdown preview

## Requirements

The markdown-preview.nvim plugin requires:

- Neovim >= 0.5.0
- Node.js and npm (or yarn)

I've verified that you have Node.js v23.7.0 and npm v11.2.0 installed on your system, which should be sufficient for the plugin to work. 