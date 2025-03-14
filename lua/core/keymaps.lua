-- keymaps.lua
-- Key mappings for Neovim

local keymap = vim.keymap

---------------------
-- General Keymaps
---------------------

-- Clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Delete single character without copying into register
keymap.set("n", "x", '"_x', { desc = "Delete character without copying" })

-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })

-- Tab management
keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" })

-- Buffer navigation
keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Go to next buffer" })
keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Go to previous buffer" })
keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete current buffer" })

-- Move lines up and down in visual mode
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Keep cursor centered when scrolling
keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Keep cursor centered when searching
keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Paste over without yanking
keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over without yanking" })

-- Yank to system clipboard
keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Delete without yanking
keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete without yanking" })

-- Quick save and quit
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<leader>wq", ":wq<CR>", { desc = "Save and quit" })

-- Better window navigation
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate to bottom window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate to top window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate to right window" })

-- Resize windows with arrows
keymap.set("n", "<C-Up>", ":resize -2<CR>", { desc = "Decrease window height" })
keymap.set("n", "<C-Down>", ":resize +2<CR>", { desc = "Increase window height" })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Stay in indent mode when indenting
keymap.set("v", "<", "<gv", { desc = "Indent left and stay in visual mode" })
keymap.set("v", ">", ">gv", { desc = "Indent right and stay in visual mode" })

-- Escape from insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Diagnostics
keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic" })
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Add diagnostics to location list" })

-- Terminal
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" }) 