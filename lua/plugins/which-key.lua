-- which-key.lua
-- Enhanced which-key configuration for better keymap discoverability

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    -- Setup which-key
    local which_key = require("which-key")
    
    which_key.setup({
      plugins = {
        marks = true, -- Shows a list of your marks on ' and `
        registers = true, -- Shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = true, -- Enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- How many suggestions should be shown in the list?
        },
        -- The presets plugin, adds help for a bunch of default keybindings in Neovim
        presets = {
          operators = true, -- Adds help for operators like d, y, ...
          motions = true, -- Adds help for motions
          text_objects = true, -- Help for text objects triggered after entering an operator
          windows = true, -- Default bindings on <c-w>
          nav = true, -- Misc bindings to work with windows
          z = true, -- Bindings for folds, spelling and others prefixed with z
          g = true, -- Bindings for prefixed with g
        },
      },
      -- Add operators that will trigger motion and text object completion
      operators = { gc = "Comments" },
      key_labels = {
        -- Override the label used to display some keys. It doesn't effect WK in any other way.
        ["<space>"] = "SPC",
        ["<cr>"] = "RET",
        ["<tab>"] = "TAB",
      },
      motions = {
        count = true,
      },
      icons = {
        breadcrumb = "»", -- Symbol used in the command line area that shows your active key combo
        separator = "➜", -- Symbol used between a key and it's label
        group = "+", -- Symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = "<c-d>", -- Binding to scroll down inside the popup
        scroll_up = "<c-u>", -- Binding to scroll up inside the popup
      },
      window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- Hide mapping boilerplate
      show_help = true, -- Show a help message in the command line for using WhichKey
      show_keys = true, -- Show the currently pressed key and its label as a message in the command line
      triggers = "auto", -- Automatically setup triggers
      -- Triggers for WhichKey to show
      triggers_nowait = {
        -- Marks
        "`",
        "'",
        "g`",
        "g'",
        -- Registers
        '"',
        "<c-r>",
        -- Spelling
        "z=",
      },
      triggers_blacklist = {
        -- List of mode / prefixes that should never be hooked by WhichKey
        i = { "j", "k" },
        v = { "j", "k" },
      },
      -- Disable the WhichKey popup for certain buf types and file types.
      disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
      },
    })
    
    -- Register all keymaps
    which_key.register({
      -- Top level mappings (no prefix)
      ["<C-h>"] = { "Move to left window" },
      ["<C-j>"] = { "Move to lower window" },
      ["<C-k>"] = { "Move to upper window" },
      ["<C-l>"] = { "Move to right window" },
      ["<A-h>"] = { "Resize window left" },
      ["<A-j>"] = { "Resize window down" },
      ["<A-k>"] = { "Resize window up" },
      ["<A-l>"] = { "Resize window right" },
      ["<C-\\>"] = { "Toggle terminal" },
      ["<C-space>"] = { "Increment selection" },
      ["<bs>"] = { "Decrement selection" },
      ["[c"] = { "Previous git hunk" },
      ["]c"] = { "Next git hunk" },
      ["[d"] = { "Previous diagnostic" },
      ["]d"] = { "Next diagnostic" },
      ["[t"] = { "Previous todo comment" },
      ["]t"] = { "Next todo comment" },
      ["[["] = { "Previous reference" },
      ["]]"] = { "Next reference" },
      ["zR"] = { "Open all folds" },
      ["zM"] = { "Close all folds" },
      ["zr"] = { "Open folds except kinds" },
      ["zm"] = { "Close folds with" },
      ["zp"] = { "Peek folded lines" },
      
      -- Leader mappings
      ["<leader>"] = {
        -- File operations
        ["e"] = { "Toggle file explorer" },
        ["ef"] = { "Find current file in explorer" },
        
        -- Find (Telescope)
        f = {
          name = "Find",
          f = { "Find files" },
          g = { "Live grep" },
          b = { "Find buffers" },
          h = { "Find help tags" },
          r = { "Find recent files" },
          t = { "Find todo comments" },
          s = { "Find symbols" },
          c = { "Find commands" },
          d = { "Find diagnostics" },
          p = { "Find projects" },
          w = { "Find word under cursor" },
        },
        
        -- Buffer operations
        b = {
          name = "Buffer",
          p = { "Previous buffer" },
          n = { "Next buffer" },
          c = { "Pick buffer to close" },
          b = { "Pick buffer" },
          s = { "Sort buffers by directory" },
          t = { "Sort buffers by tabs" },
          d = { "Delete current buffer" },
        },
        
        -- Window operations
        w = {
          name = "Window",
          h = { "Swap with left window" },
          j = { "Swap with lower window" },
          k = { "Swap with upper window" },
          l = { "Swap with right window" },
          m = { "Maximize window" },
          e = { "Equalize windows" },
          a = { "Toggle auto-width" },
          p = { "Pick a window" },
        },
        
        -- Terminal operations
        t = {
          name = "Terminal",
          t = { "Toggle floating terminal" },
          h = { "Toggle horizontal terminal" },
          v = { "Toggle vertical terminal" },
          g = { "Toggle Lazygit" },
          n = { "Toggle Node" },
          p = { "Toggle Python" },
        },
        
        -- Git operations
        h = {
          name = "Git",
          s = { "Stage hunk" },
          r = { "Reset hunk" },
          S = { "Stage buffer" },
          u = { "Undo stage hunk" },
          R = { "Reset buffer" },
          p = { "Preview hunk" },
          b = { "Blame line" },
          d = { "Diff against index" },
          D = { "Diff against last commit" },
          t = {
            name = "Toggle",
            b = { "Toggle blame line" },
            d = { "Toggle deleted" },
          },
        },
        
        -- LSP operations
        l = {
          name = "LSP",
          a = { "Code action" },
          d = { "Definition" },
          D = { "Declaration" },
          i = { "Implementation" },
          r = { "References" },
          R = { "Rename" },
          f = { "Format" },
          t = { "Type definition" },
          s = { "Document symbols" },
          S = { "Workspace symbols" },
          h = { "Hover" },
          I = { "Incoming calls" },
          O = { "Outgoing calls" },
          e = { "Show line diagnostics" },
          q = { "Show diagnostics in quickfix" },
        },
        
        -- Swap operations
        s = {
          name = "Swap",
          a = { "Swap next parameter" },
          A = { "Swap previous parameter" },
          f = { "Swap next function" },
          F = { "Swap previous function" },
          c = { "Swap next class" },
          C = { "Swap previous class" },
        },
        
        -- Focus mode
        z = {
          name = "Focus",
          z = { "Toggle Zen mode" },
        },
        ["tw"] = { "Toggle Twilight (dim inactive code)" },
        
        -- Session management
        q = {
          name = "Session",
          s = { "Restore session" },
          l = { "Restore last session" },
          d = { "Don't save current session" },
        },
        
        -- Colorscheme
        ["cs"] = { "Switch colorscheme" },
      },
      
      -- Visual mode mappings
      ["<leader>"] = {
        h = {
          name = "Git",
          s = { "Stage selection" },
          r = { "Reset selection" },
        },
      },
      
      -- Add PHP and Laravel specific mappings
      ["<leader>p"] = {
        name = "PHP",
        f = { "<cmd>lua require('conform').format({ bufnr = 0, lsp_fallback = true })<cr>", "Format PHP" },
        r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename Symbol" },
        a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
        d = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Line Diagnostics" },
      },
      
      ["<leader>l"] = {
        name = "Laravel",
        a = { "<cmd>Laravel artisan<cr>", "Artisan Commands" },
        r = { "<cmd>Laravel routes<cr>", "Routes" },
        m = { "<cmd>Laravel models<cr>", "Models" },
        c = { "<cmd>Laravel commands<cr>", "Commands" },
        v = { "<cmd>Laravel views<cr>", "Views" },
        e = { "<cmd>edit .env<cr>", "Edit .env" },
      },
    })
  end,
} 