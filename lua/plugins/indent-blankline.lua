-- indent-blankline.lua
-- Configuration for indent line visualization

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    -- Load the indent-blankline plugin
    local ibl = require("ibl")
    local hooks = require("ibl.hooks")
    
    -- Configure the plugin with nice defaults
    ibl.setup({
      -- Configure indent lines
      indent = {
        char = "│", -- Character to use for indent line
        tab_char = "│", -- Character to use for tab indent
      },
      -- Configure scope highlighting (shows current scope with different color)
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
        injected_languages = true,
        highlight = { "Function", "Label" },
        priority = 500,
      },
      -- Exclude certain filetypes
      exclude = {
        filetypes = {
          "help",
          "terminal",
          "lazy",
          "lspinfo",
          "TelescopePrompt",
          "TelescopeResults",
          "mason",
          "nvdash",
          "nvcheatsheet",
          "dashboard",
          "NvimTree",
        },
        buftypes = {
          "terminal",
          "nofile",
          "quickfix",
          "prompt",
        },
      },
    })
    
    -- Add keymaps to toggle indent lines and scope highlighting
    vim.keymap.set("n", "<leader>ti", function()
      local config = require("ibl.config").get_config()
      if config.enabled then
        ibl.setup({ enabled = false })
        print("Indent lines disabled")
      else
        ibl.setup({ enabled = true })
        print("Indent lines enabled")
      end
    end, { desc = "Toggle indent lines" })
    
    vim.keymap.set("n", "<leader>ts", function()
      local config = require("ibl.config").get_config()
      if config.scope.enabled then
        ibl.setup({ scope = { enabled = false } })
        print("Scope highlighting disabled")
      else
        ibl.setup({ scope = { enabled = true } })
        print("Scope highlighting enabled")
      end
    end, { desc = "Toggle scope highlighting" })
  end,
} 