-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.colorscheme.nightfox-nvim" },
    { import = "astrocommunity.recipes.telescope-nvchad-theme" },
    { import = "astrocommunity.bars-and-lines.dropbar-nvim" },
    { import = "astrocommunity.docker.lazydocker" },
    { import = "astrocommunity.bars-and-lines.vim-illuminate" },
    { import = "astrocommunity.bars-and-lines.smartcolumn-nvim" },

    { import = "astrocommunity.git.diffview-nvim" },
    { import = "astrocommunity.git.gitgraph-nvim" },
    { import = "astrocommunity.git.octo-nvim" },

    { import = "astrocommunity.motion.flash-nvim" },
    { import = "astrocommunity.motion.nvim-surround" },

    { import = "astrocommunity.indent.mini-indentscope" },

    -- { import = "astrocommunity.pack.php" },
    { import = "astrocommunity.pack.laravel" },
    { import = "astrocommunity.pack.go" },

    { import = "astrocommunity.pack.tailwindcss" },
    { import = "astrocommunity.pack.typescript-all-in-one" },
}
