-- colorscheme.lua
-- Enhanced colorscheme options for a beautiful Neovim experience

return {
  -- Tokyo Night - A clean, dark Neovim theme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000, -- Load before other plugins
    config = function()
      -- Configure the colorscheme
      require("tokyonight").setup({
        -- Choose the style: storm, moon, night, day
        style = "storm",
        -- Enable light style when system is in light mode
        light_style = "day",
        -- Enable transparent background
        transparent = false,
        -- Enable terminal colors
        terminal_colors = true,
        -- Style settings
        styles = {
          -- Style for syntax elements
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
          variables = {},
          -- Style for background elements
          sidebars = "dark",
          floats = "dark",
        },
        -- Customize specific highlight groups
        on_highlights = function(highlights, colors)
          -- Make line numbers more visible
          highlights.LineNr = { fg = colors.blue:lighten(20) }
          -- Enhance the cursor line
          highlights.CursorLine = { bg = colors.bg_highlight:lighten(5) }
          -- Make matching parentheses more visible
          highlights.MatchParen = { fg = colors.orange, bold = true }
          -- Enhance visual selection
          highlights.Visual = { bg = colors.blue:darken(80), fg = colors.white }
        end,
      })
      
      -- Set the colorscheme
      vim.cmd("colorscheme tokyonight")
    end,
  },
  
  -- Catppuccin - Soothing pastel theme for Neovim
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    config = function()
      require("catppuccin").setup({
        -- Choose the flavor: latte, frappe, macchiato, mocha
        flavour = "mocha",
        -- Enable transparent background
        transparent_background = false,
        -- Show terminal colors
        term_colors = true,
        -- Styles for syntax elements
        styles = {
          comments = { "italic" },
          conditionals = { "italic" },
          loops = {},
          functions = { "bold" },
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
        },
        -- Customize specific highlight groups
        custom_highlights = function(colors)
          return {
            LineNr = { fg = colors.blue },
            CursorLine = { bg = colors.surface0 },
            MatchParen = { fg = colors.peach, style = { "bold" } },
            Visual = { bg = colors.surface2 },
          }
        end,
        -- Integration with other plugins
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          telescope = true,
          treesitter = true,
          notify = true,
          which_key = true,
          indent_blankline = {
            enabled = true,
            colored_indent_levels = true,
          },
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { "italic" },
              hints = { "italic" },
              warnings = { "italic" },
              information = { "italic" },
            },
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })
    end,
  },
  
  -- Kanagawa - A dark, relaxing theme inspired by The Great Wave painting
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    config = function()
      require("kanagawa").setup({
        -- Choose the style: wave, dragon, lotus
        theme = "wave",
        -- Enable transparent background
        transparent = false,
        -- Terminal colors
        terminalColors = true,
        -- Style settings
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = { bold = true },
          strings = {},
          variables = {},
        },
        -- Customize specific highlight groups
        overrides = function(colors)
          return {
            LineNr = { fg = colors.crystalBlue },
            CursorLine = { bg = colors.sumiInk2 },
            MatchParen = { fg = colors.sakuraPink, bold = true },
            Visual = { bg = colors.sumiInk3 },
          }
        end,
      })
    end,
  },
  
  -- Nightfox - A highly customizable theme with multiple styles
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
    config = function()
      require("nightfox").setup({
        -- Choose the style: nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox
        style = "nightfox",
        -- Enable transparent background
        transparent = false,
        -- Terminal colors
        terminal_colors = true,
        -- Style settings
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold",
        },
        -- Customize specific highlight groups
        groups = {
          all = {
            LineNr = { fg = "palette.blue.bright" },
            CursorLine = { bg = "palette.bg1" },
            MatchParen = { fg = "palette.orange", style = "bold" },
            Visual = { bg = "palette.bg3" },
          },
        },
      })
    end,
  },
  
  -- Colorscheme switcher command
  {
    "folke/tokyonight.nvim",
    keys = {
      { "<leader>cs", "<cmd>lua require('plugins.colorscheme-switcher').switch()<CR>", desc = "Switch Colorscheme" },
    },
    config = function()
      -- Create a module for colorscheme switching
      local M = {}
      
      -- List of available colorschemes
      M.colorschemes = {
        "tokyonight-storm",
        "tokyonight-night",
        "tokyonight-moon",
        "tokyonight-day",
        "catppuccin",
        "catppuccin-latte",
        "catppuccin-frappe",
        "catppuccin-macchiato",
        "catppuccin-mocha",
        "kanagawa",
        "kanagawa-wave",
        "kanagawa-dragon",
        "kanagawa-lotus",
        "nightfox",
        "dayfox",
        "dawnfox",
        "duskfox",
        "nordfox",
        "terafox",
        "carbonfox",
      }
      
      -- Function to switch colorscheme
      function M.switch()
        -- Create a Telescope picker for colorschemes
        require("telescope.builtin").colorscheme({
          enable_preview = true,
          prompt_title = "Switch Colorscheme",
          results_title = "Available Colorschemes",
          layout_config = {
            width = 0.6,
            height = 0.8,
          },
        })
      end
      
      -- Save the module
      package.loaded["plugins.colorscheme-switcher"] = M
    end,
  },
} 