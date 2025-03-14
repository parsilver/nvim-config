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
opt.scrolloff = 10        -- Min number of lines to keep above and below cursor
opt.sidescrolloff = 10    -- Min number of columns to keep to the left/right of cursor
opt.cmdheight = 1         -- More space for displaying messages
opt.pumheight = 10        -- Maximum number of items to show in the popup menu
opt.pumblend = 10         -- Pseudo-transparency for popup-menu
opt.winblend = 10         -- Pseudo-transparency for floating windows

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
opt.writebackup = false   -- Don't create a backup before overwriting a file

-- Update time
opt.updatetime = 50       -- Faster completion
opt.timeoutlen = 300      -- Time to wait for a mapped sequence to complete (in milliseconds)

-- Completion
opt.completeopt = "menuone,noselect" -- Better completion experience

-- Wild menu
opt.wildmenu = true       -- Command-line completion
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.wildoptions = "pum"   -- Use popup menu for wildmode

-- Misc
opt.iskeyword:append("-") -- Consider string-string as whole word
opt.mouse = "a"           -- Enable mouse support
opt.showmode = false      -- Don't show mode since we have a statusline
opt.conceallevel = 0      -- Show text normally
opt.fileencoding = "utf-8" -- Encoding written to a file
opt.confirm = true        -- Confirm to save changes before exiting modified buffer
opt.title = true          -- Set the title of window to the value of the titlestring
opt.laststatus = 3        -- Global statusline
opt.showtabline = 2       -- Always show tabline
opt.fillchars = {
  eob = " ",              -- No ~ for end of buffer
  fold = " ",             -- No dots for folds
  foldopen = "+",         -- Symbol for open folds (using standard ASCII)
  foldsep = " ",          -- Symbol for fold separator
  foldclose = ">",        -- Symbol for closed folds (using standard ASCII)
  diff = "/",             -- Symbol for diff (using standard ASCII)
  msgsep = "-",           -- Symbol for message separator
  horiz = "-",            -- Symbol for horizontal split
  horizup = "+",          -- Symbol for horizontal split (up)
  horizdown = "+",        -- Symbol for horizontal split (down)
  vert = "|",             -- Symbol for vertical split
  vertleft = "+",         -- Symbol for vertical split (left)
  vertright = "+",        -- Symbol for vertical split (right)
  verthoriz = "+",        -- Symbol for vertical and horizontal split
}

-- Better folds
opt.foldmethod = "expr"   -- Use treesitter for folds
opt.foldexpr = "nvim_treesitter#foldexpr()" -- Use treesitter for folds
opt.foldlevel = 99        -- Don't fold by default
opt.foldlevelstart = 99   -- Don't fold by default
opt.foldenable = true     -- Enable folding

-- Better UI
opt.shortmess:append("c") -- Don't show completion messages
opt.shortmess:append("I") -- Don't show intro message
opt.shortmess:append("W") -- Don't show written message
opt.shortmess:append("a") -- Use abbreviations

-- Cursor settings
opt.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50" -- Cursor style
                .. ",a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor"
                .. ",sm:block-blinkwait175-blinkoff150-blinkon175"

-- Format options
opt.formatoptions = opt.formatoptions
  - "a" -- Auto formatting is BAD.
  - "t" -- Don't auto format my code. I got linters for that.
  + "c" -- In general, I like it when comments respect textwidth
  + "q" -- Allow formatting comments w/ gq
  - "o" -- O and o, don't continue comments
  + "r" -- But do continue when pressing enter.
  + "n" -- Indent past the formatlistpat, not underneath it.
  + "j" -- Auto-remove comments if possible.
  - "2" -- I'm not in gradeschool anymore

-- Netrw settings (built-in file explorer)
g.netrw_banner = 0        -- Hide banner
g.netrw_liststyle = 3     -- Tree view
g.netrw_browse_split = 0  -- Open in current window
g.netrw_winsize = 25      -- Width of explorer window

-- Disable some built-in plugins
local disabled_built_ins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
  g["loaded_" .. plugin] = 1
end

-- Create directories if they don't exist
local cache_dir = vim.fn.stdpath("cache")
local dirs = {
  cache_dir .. "/backup",
  cache_dir .. "/session",
  cache_dir .. "/swap",
  cache_dir .. "/tags",
  cache_dir .. "/undo",
}

for _, dir in pairs(dirs) do
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

-- Set undo directory
opt.undodir = cache_dir .. "/undo"

-- Set backup directory
opt.backupdir = cache_dir .. "/backup"

-- Set directory for swap files
opt.directory = cache_dir .. "/swap"

-- Set spell file
opt.spellfile = cache_dir .. "/spell/en.utf-8.add"

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
  end,
})

-- Remember cursor position
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto resize windows when terminal is resized
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Auto create directories when saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- Disable auto comment on new line
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.opt_local.formatoptions:remove({ "c", "r", "o" })
  end,
})

-- Set wrap and spell for text filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit", "markdown", "text" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Improve terminal experience
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
    vim.cmd("startinsert")
  end,
})

-- Close terminal buffer on process exit
vim.api.nvim_create_autocmd("TermClose", {
  callback = function()
    vim.cmd("bdelete!")
  end,
}) 