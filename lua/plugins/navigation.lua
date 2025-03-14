-- navigation.lua
-- Enhanced navigation and window management for better UX

return {
  -- Smart window navigation and resizing
  {
    "mrjones2014/smart-splits.nvim",
    event = "VeryLazy",
    config = function()
      -- Configure smart-splits
      require("smart-splits").setup({
        -- Ignored filetypes (only while resizing)
        ignored_filetypes = {
          "nofile",
          "quickfix",
          "prompt",
        },
        -- Ignored buffer types (only while resizing)
        ignored_buftypes = { "NvimTree" },
        -- Default split direction
        default_amount = 3,
        -- Wrap to opposite side when reaching edge
        wrap_at_edge = true,
        -- Cursor movement within wrapped lines
        move_cursor_same_row = false,
        -- Resize mode options
        resize_mode = {
          -- Key to exit resize mode
          quit_key = "<ESC>",
          -- Keys to use for resizing
          resize_keys = { "h", "j", "k", "l" },
          -- Size of each resize step
          resize_amount = 5,
          -- Show arrows during resize
          silent = false,
        },
        -- Ignored buffer-local options while resizing
        ignored_events = {
          "BufEnter",
          "WinEnter",
        },
      })
      
      -- Keymaps for window navigation
      vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Move to left window" })
      vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Move to lower window" })
      vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Move to upper window" })
      vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Move to right window" })
      
      -- Keymaps for window resizing
      vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left, { desc = "Resize window left" })
      vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down, { desc = "Resize window down" })
      vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up, { desc = "Resize window up" })
      vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right, { desc = "Resize window right" })
      
      -- Keymaps for swapping windows
      vim.keymap.set("n", "<leader>wh", require("smart-splits").swap_buf_left, { desc = "Swap with left window" })
      vim.keymap.set("n", "<leader>wj", require("smart-splits").swap_buf_down, { desc = "Swap with lower window" })
      vim.keymap.set("n", "<leader>wk", require("smart-splits").swap_buf_up, { desc = "Swap with upper window" })
      vim.keymap.set("n", "<leader>wl", require("smart-splits").swap_buf_right, { desc = "Swap with right window" })
    end,
  },
  
  -- Window picker for easier navigation
  {
    "s1n7ax/nvim-window-picker",
    event = "VeryLazy",
    version = "2.*",
    config = function()
      -- Configure window picker
      require("window-picker").setup({
        -- Filter using buffer options
        filter_rules = {
          -- Filter using buffer options
          bo = {
            -- Ignore these filetypes
            filetype = { "NvimTree", "neo-tree", "notify", "quickfix" },
            -- Ignore these buftypes
            buftype = { "terminal", "quickfix" },
          },
        },
        -- Highlight options
        highlights = {
          -- Highlight for window selection
          statusline = {
            focused = {
              fg = "#ededed",
              bg = "#e35e4f",
              bold = true,
            },
            unfocused = {
              fg = "#ededed",
              bg = "#44cc41",
              bold = true,
            },
          },
          -- Highlight for window selection hint
          winbar = {
            focused = {
              fg = "#ededed",
              bg = "#e35e4f",
              bold = true,
            },
            unfocused = {
              fg = "#ededed",
              bg = "#44cc41",
              bold = true,
            },
          },
        },
      })
      
      -- Keymap for picking a window
      vim.keymap.set("n", "<leader>wp", function()
        local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(picked_window_id)
      end, { desc = "Pick a window" })
    end,
  },
  
  -- Better window management
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen"
    end,
    opts = {
      -- Bottom panel
      bottom = {
        -- Terminal at the bottom with a height of 15 rows
        {
          ft = "toggleterm",
          size = { height = 15 },
          -- exclude floating windows
          filter = function(buf, win)
            return vim.api.nvim_win_get_config(win).relative == ""
          end,
        },
        -- Trouble diagnostics at the bottom
        "Trouble",
        -- Output of commands
        { ft = "qf", title = "QuickFix" },
        {
          ft = "help",
          size = { height = 20 },
          -- Only open help in bottom if it was opened as a vertical split
          filter = function(buf, win)
            return vim.bo[buf].buftype == "help"
              and vim.api.nvim_win_get_width(win) < vim.o.columns * 0.5
          end,
        },
      },
      -- Left panel
      left = {
        -- File explorer on the left with a width of 30 columns
        {
          title = "Files",
          ft = "NvimTree",
          size = { width = 30 },
        },
        -- Outline of the current file
        {
          title = "Outline",
          ft = "Outline",
          pinned = true,
          open = "SymbolsOutline",
        },
      },
      -- Right panel
      right = {
        -- Git changes
        { ft = "git", title = "Git" },
      },
      -- Options
      options = {
        -- Left and right panels are not resizable
        left = { size = 30 },
        right = { size = 30 },
        -- Bottom panel is resizable
        bottom = { size = 15, resize = true },
      },
      -- Animations
      animate = {
        enabled = true,
        fps = 100,
        cps = 120,
        on_begin = function()
          vim.g.minianimate_disable = true
        end,
        on_end = function()
          vim.g.minianimate_disable = false
        end,
        -- Spinner for when a panel is being opened
        spinner = {
          frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" },
          interval = 80,
        },
      },
      -- Icons used in titles
      icons = {
        closed = " ",
        open = " ",
      },
      -- Close edgy when it's the last window
      close_when_last = false,
      -- Disable the feature completely for specific filetypes
      exclude_filetypes = { "prompt" },
      -- Keys used for navigation
      keys = {
        -- Quit edgy
        ["q"] = function(win)
          win:close()
        end,
        -- Toggle maximize
        ["<c-w>"] = function(win)
          win:toggle_maximize()
        end,
      },
    },
  },
  
  -- Smooth window animations
  {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      
      require("windows").setup({
        -- Automatically resize windows on terminal resize
        autowidth = {
          enable = true,
          winwidth = 0,
          filetype = {
            help = 2,
          },
        },
        -- Animation settings
        animation = {
          enable = true,
          duration = 300,
          fps = 60,
          easing = "in_out_sine",
        },
        -- Ignore specific filetypes
        ignore = {
          buftype = { "quickfix" },
          filetype = { "NvimTree", "neo-tree", "undotree", "gundo" },
        },
      })
      
      -- Keymap for maximizing the current window
      vim.keymap.set("n", "<leader>wm", "<Cmd>WindowsMaximize<CR>", { desc = "Maximize window" })
      -- Keymap for equalizing all windows
      vim.keymap.set("n", "<leader>we", "<Cmd>WindowsEqualize<CR>", { desc = "Equalize windows" })
      -- Keymap for toggling auto-width
      vim.keymap.set("n", "<leader>wa", "<Cmd>WindowsToggleAutowidth<CR>", { desc = "Toggle auto-width" })
    end,
  },
  
  -- Better terminal integration
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        -- Size can be a number or function
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.4
          end
        end,
        -- Open in insert mode
        open_mapping = [[<c-\>]],
        -- Hide the number column
        hide_numbers = true,
        -- Shade the terminal
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2,
        -- Start in insert mode
        start_in_insert = true,
        -- Close terminal on process exit
        close_on_exit = true,
        -- Shell to use
        shell = vim.o.shell,
        -- Terminal window mappings
        -- direction = 'vertical' | 'horizontal' | 'tab' | 'float'
        direction = "float",
        -- Float configuration
        float_opts = {
          -- Border style
          border = "curved",
          -- Width and height
          width = 80,
          height = 20,
          -- Window options
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
      })
      
      -- Custom terminal functions
      local Terminal = require("toggleterm.terminal").Terminal
      
      -- Lazygit terminal
      local lazygit = Terminal:new({
        cmd = "lazygit",
        hidden = true,
        direction = "float",
        float_opts = {
          border = "curved",
          width = math.floor(vim.o.columns * 0.9),
          height = math.floor(vim.o.lines * 0.9),
        },
      })
      
      -- Function to toggle lazygit
      function _G.toggle_lazygit()
        lazygit:toggle()
      end
      
      -- Node terminal
      local node = Terminal:new({ cmd = "node", hidden = true })
      
      -- Function to toggle node
      function _G.toggle_node()
        node:toggle()
      end
      
      -- Python terminal
      local python = Terminal:new({ cmd = "python", hidden = true })
      
      -- Function to toggle python
      function _G.toggle_python()
        python:toggle()
      end
      
      -- Keymaps for terminals
      vim.keymap.set("n", "<leader>tg", "<cmd>lua toggle_lazygit()<CR>", { desc = "Toggle Lazygit" })
      vim.keymap.set("n", "<leader>tn", "<cmd>lua toggle_node()<CR>", { desc = "Toggle Node" })
      vim.keymap.set("n", "<leader>tp", "<cmd>lua toggle_python()<CR>", { desc = "Toggle Python" })
      vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle Terminal (float)" })
      vim.keymap.set("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Toggle Terminal (horizontal)" })
      vim.keymap.set("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Toggle Terminal (vertical)" })
    end,
  },
  
  -- Better tab management
  {
    "tiagovla/scope.nvim",
    event = "VeryLazy",
    config = function()
      -- Setup scope.nvim for better tab management
      require("scope").setup({
        restore_state = true,
      })
    end,
  },
  
  -- Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      -- Directory where session files are stored
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
      -- Options to save with the session
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
      -- Don't save when these filetypes are active
      pre_save = nil,
      -- Save session on these events
      save_interval = 60 * 30, -- Save every 30 minutes
    },
    -- Keymaps for session management
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
} 