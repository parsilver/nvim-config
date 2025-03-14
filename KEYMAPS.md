# Neovim Keymaps Documentation

This document explains all the keymaps in this Neovim configuration, including some intentionally overlapping keymaps.

## Leader Key

The leader key is set to `<Space>`.

## General Keymaps

- `<leader>w` - Save file
- `<leader>q` - Quit
- `<leader>wq` - Save and quit
- `jk` - Exit insert mode
- `<leader>nh` - Clear search highlights
- `x` - Delete character without copying into register
- `<leader>+` - Increment number
- `<leader>-` - Decrement number

## Window Management

- `<C-h/j/k/l>` - Navigate between windows
- `<leader>sv` - Split window vertically
- `<leader>sh` - Split window horizontally
- `<leader>se` - Make splits equal size
- `<leader>sx` - Close current split
- `<C-Up/Down/Left/Right>` - Resize windows

## Tab Management

- `<leader>to` - Open new tab
- `<leader>tx` - Close current tab
- `<leader>tn` - Go to next tab
- `<leader>tp` - Go to previous tab

## Buffer Navigation

- `<leader>bn` - Go to next buffer
- `<leader>bp` - Go to previous buffer
- `<leader>bd` - Delete current buffer
- `<leader>bc` - Pick buffer to close
- `<leader>bb` - Pick buffer
- `<leader>bs` - Sort buffers by directory
- `<leader>bt` - Sort buffers by tabs
- `<leader>1-9` - Go to buffer 1-9
- `<leader>$` - Go to last buffer

## File Explorer (NvimTree)

- `<leader>e` - Toggle file explorer
- `<leader>ef` - Find current file in explorer

## Telescope (Fuzzy Finder)

- `<leader>ff` - Find files
- `<leader>fg` - Find text (grep)
- `<leader>fb` - Find buffers
- `<leader>fh` - Find help
- `<leader>fr` - Find recent files
- `<leader>fc` - Find word under cursor

## LSP

- `gd` - Go to definition
- `gD` - Go to declaration
- `gr` - Find references
- `K` - Show hover documentation
- `<leader>lr` - Rename symbol
- `<leader>la` - Code action
- `<leader>lf` - Format code
- `[d` / `]d` - Previous/next diagnostic
- `<leader>ld` - Open floating diagnostic
- `<leader>lq` - Add diagnostics to location list

## Git

- `<leader>hs` - Stage hunk
- `<leader>hr` - Reset hunk
- `<leader>hb` - Blame line
- `<leader>hd` - Diff this
- `]c` / `[c` - Next/previous hunk
- `<leader>hS` - Stage buffer
- `<leader>hu` - Undo stage hunk
- `<leader>hR` - Reset buffer
- `<leader>hp` - Preview hunk
- `<leader>tb` - Toggle line blame
- `<leader>td` - Toggle deleted

## Text Manipulation

- `J` / `K` (visual mode) - Move selected lines down/up
- `<leader>p` (visual mode) - Paste over without yanking
- `<leader>y` - Yank to system clipboard
- `<leader>Y` - Yank line to system clipboard
- `<leader>d` - Delete without yanking
- `<` / `>` (visual mode) - Indent left/right and stay in visual mode

## Terminal

- `<leader>tt` - Open terminal
- `<Esc>` (terminal mode) - Exit terminal mode

## Comments (Comment.nvim)

- `gc` - Comment toggle linewise
- `gb` - Comment toggle blockwise
- `gcc` - Comment toggle current line
- `gbc` - Comment toggle current block
- `gcO` - Comment insert above
- `gco` - Comment insert below
- `gcA` - Comment insert end of line

## Toggle Features

- `<leader>ti` - Toggle indent lines
- `<leader>ts` - Toggle scope highlighting
- `<leader>tb` - Toggle line blame (Git)
- `<leader>td` - Toggle deleted (Git)

## Markdown Preview

- `<leader>mp` - Start markdown preview
- `<leader>ms` - Stop markdown preview
- `<leader>mt` - Toggle markdown preview

## Intentionally Overlapping Keymaps

Some keymaps intentionally overlap for better usability:

1. **Comment.nvim Keymaps**:
   - `gc` is the base for linewise comments, while `gcc`, `gco`, `gcO`, and `gcA` are specific comment operations
   - `gb` is the base for blockwise comments, while `gbc` is for the current block

2. **File Explorer**:
   - `<leader>e` toggles the file explorer
   - `<leader>ef` finds the current file in the explorer

3. **Save and Quit**:
   - `<leader>w` saves the file
   - `<leader>wq` saves and quits

4. **Delete and Diagnostics**:
   - `<leader>d` deletes without yanking
   - `<leader>dl` adds diagnostics to the location list

5. **Buffer Navigation**:
   - `<leader>b` prefix is used for all buffer operations
   - `<leader>1-9` provides quick access to specific buffers by number
   - `<leader>$` jumps to the last buffer

6. **Markdown Preview**:
   - `<leader>m` prefix is used for all markdown operations
   - These keymaps are only active in markdown files

These overlapping keymaps are by design and provide a logical hierarchy of commands. 