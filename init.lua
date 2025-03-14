-- init.lua
-- Main Neovim configuration file
-- Author: parsilver

-- Automatically install lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key before loading plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load core configurations
require('core.options')    -- General Neovim options
require('core.keymaps')    -- Key mappings
require('core.plugins')    -- Plugin management with lazy.nvim

-- Initialize lazy.nvim
require("lazy").setup("plugins")

-- Load colorscheme after plugins are loaded
require('core.colorscheme') -- Colorscheme configuration 