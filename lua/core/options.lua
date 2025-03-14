-- options.lua
-- General Neovim options and settings

local opt = vim.opt
local g = vim.g

-- Line numbers
opt.number = true         -- Show line numbers
opt.relativenumber = true -- Show relative line numbers

-- Tabs & Indentation
opt.tabstop = 2           -- 2 spaces for tabs
opt.shiftwidth = 2        -- 2 spaces for indent width
opt.expandtab = true      -- Expand tabs to spaces
opt.autoindent = true     -- Copy indent from current line when starting new one
opt.smartindent = true    -- Smart autoindenting when starting a new line

-- Line wrapping
opt.wrap = false          -- Disable line wrapping

-- Search settings
opt.ignorecase = true     -- Ignore case when searching
opt.smartcase = true      -- If you include mixed case in your search, assumes you want case-sensitive
opt.hlsearch = true       -- Highlight all matches on previous search pattern
opt.incsearch = true      -- Show matches while typing

-- Cursor line
opt.cursorline = true     -- Highlight the current line

-- Appearance
opt.termguicolors = true  -- True color support
opt.background = "dark"   -- Dark theme
opt.signcolumn = "yes"    -- Always show the sign column
opt.scrolloff = 8         -- Min number of lines to keep above and below cursor
opt.sidescrolloff = 8     -- Min number of columns to keep to the left/right of cursor

-- Backspace
opt.backspace = "indent,eol,start" -- Allow backspace on indent, end of line or insert mode start position

-- Clipboard
opt.clipboard:append("unnamedplus") -- Use system clipboard

-- Split windows
opt.splitright = true     -- Split vertical window to the right
opt.splitbelow = true     -- Split horizontal window to the bottom

-- Swapfile and backup
opt.swapfile = false      -- Don't use swapfile
opt.backup = false        -- Don't create backup files
opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Set undodir
opt.undofile = true       -- Enable persistent undo

-- Update time
opt.updatetime = 50       -- Faster completion
opt.timeoutlen = 300      -- Time to wait for a mapped sequence to complete (in milliseconds)

-- Completion
opt.completeopt = "menuone,noselect" -- Better completion experience

-- Wild menu
opt.wildmenu = true       -- Command-line completion
opt.wildmode = "longest:full,full" -- Command-line completion mode

-- Misc
opt.iskeyword:append("-") -- Consider string-string as whole word
opt.mouse = "a"           -- Enable mouse support
opt.pumheight = 10        -- Maximum number of items to show in the popup menu
opt.showmode = false      -- Don't show mode since we have a statusline
opt.conceallevel = 0      -- Show text normally
opt.fileencoding = "utf-8" -- Encoding written to a file
opt.confirm = true        -- Confirm to save changes before exiting modified buffer
opt.title = true          -- Set the title of window to the value of the titlestring
opt.laststatus = 3        -- Global statusline 