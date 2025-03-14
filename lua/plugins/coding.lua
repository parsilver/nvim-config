-- coding.lua
-- Enhanced code editing experience for Neovim

return {
  -- Auto pairs for brackets, quotes, etc.
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      -- Configure autopairs
      local autopairs = require("nvim-autopairs")
      
      autopairs.setup({
        -- Check treesitter for pair matching
        check_ts = true,
        -- Disable autopairs in these filetypes
        disable_filetype = { "TelescopePrompt", "vim" },
        -- Don't add pairs if it already has a close pair in the same line
        enable_check_bracket_line = true,
        -- Don't add pairs if the next char is alphanumeric
        ignored_next_char = "[%w%.]",
        -- Use treesitter to check for a pair
        ts_config = {
          lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
          javascript = { "template_string" }, -- Don't add pairs in javascript template_string
        },
        -- Fast wrap
        fast_wrap = {
          map = "<M-e>", -- Alt+e to fast wrap
          chars = { "{", "[", "(", '"', "'" },
          pattern = [=[[%'%"%>%]%)%}%,]]=],
          end_key = "$",
          keys = "qwertyuiopzxcvbnmasdfghjkl",
          check_comma = true,
          highlight = "Search",
          highlight_grey = "Comment",
        },
      })
      
      -- Integration with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      
      -- Add parentheses after selecting a function or method
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  
  -- Surround selections with brackets, quotes, etc.
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Keymaps
        keymaps = {
          insert = "<C-g>s", -- Insert mode
          insert_line = "<C-g>S", -- Insert mode, line
          normal = "ys", -- Normal mode
          normal_cur = "yss", -- Normal mode, current line
          normal_line = "yS", -- Normal mode, line
          normal_cur_line = "ySS", -- Normal mode, current line
          visual = "S", -- Visual mode
          visual_line = "gS", -- Visual mode, line
          delete = "ds", -- Delete surroundings
          change = "cs", -- Change surroundings
        },
        -- Aliases for surroundings
        aliases = {
          ["a"] = ">", -- angle brackets
          ["b"] = ")", -- brackets
          ["B"] = "}", -- braces
          ["r"] = "]", -- square brackets
          ["q"] = { '"', "'", "`" }, -- quotes
          ["s"] = { "}", "]", ")", ">", '"', "'", "`" }, -- any surrounding
        },
        -- Highlight surrounding being modified
        highlight = {
          duration = 150,
        },
        -- Move cursor after surrounding in insert mode
        move_cursor = "begin",
        -- Indent when adding surroundings on multiple lines
        indent_lines = true,
      })
    end,
  },
  
  -- Comment code with smart features
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- Configure Comment.nvim
      require("Comment").setup({
        -- Padding between comment and line
        padding = true,
        -- Whether the cursor should stay at its position
        sticky = true,
        -- Lines to be ignored while (un)comment
        ignore = nil,
        -- LHS of toggle mappings in NORMAL mode
        toggler = {
          -- Line-comment toggle keymap
          line = "gcc",
          -- Block-comment toggle keymap
          block = "gbc",
        },
        -- LHS of operator-pending mappings in NORMAL and VISUAL mode
        opleader = {
          -- Line-comment keymap
          line = "gc",
          -- Block-comment keymap
          block = "gb",
        },
        -- LHS of extra mappings
        extra = {
          -- Add comment on the line above
          above = "gcO",
          -- Add comment on the line below
          below = "gco",
          -- Add comment at the end of line
          eol = "gcA",
        },
        -- Enable keybindings
        mappings = {
          -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
          basic = true,
          -- Extra mapping; `gco`, `gcO`, `gcA`
          extra = true,
        },
        -- Function to call before (un)comment
        pre_hook = function(ctx)
          -- Get treesitter context for better commenting
          local U = require("Comment.utils")
          
          -- Determine whether to use linewise or blockwise commentstring
          local location = nil
          if ctx.ctype == U.ctype.block then
            location = require("ts_context_commentstring.utils").get_cursor_location()
          elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
            location = require("ts_context_commentstring.utils").get_visual_start_location()
          end
          
          return require("ts_context_commentstring.internal").calculate_commentstring({
            key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
            location = location,
          })
        end,
        -- Function to call after (un)comment
        post_hook = nil,
      })
    end,
  },
  
  -- Better text objects and motions
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
    config = function()
      -- Configure mini.ai
      require("mini.ai").setup({
        -- Table with textobject id as fields, textobject specification as values.
        -- Text objects are created dynamically based on this table.
        custom_textobjects = {
          -- Whole buffer
          B = function() return { from = { line = 1, col = 1 }, to = { line = vim.fn.line("$"), col = math.max(vim.fn.getline("$"):len(), 1) } } end,
          -- Line textobject
          L = function() return { from = { line = vim.fn.line("."), col = 1 }, to = { line = vim.fn.line("."), col = math.max(vim.fn.getline("."):len(), 1) } } end,
          -- Treesitter objects
          f = { "<function>", "^function %(", "^function [%w_]+ %(", "^local function [%w_]+ %(", "^local function %(", "^func" },
          c = { "<class>", "^class ", "^class$", "^classdef " },
          -- Argument textobject using treesitter
          a = require("mini.ai").gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
        },
        
        -- Module config
        n_lines = 500, -- Number of lines within which textobject is searched
        custom_textobjects = {}, -- Table mapping custom textobject identifiers to their specifications
        
        -- How to search for object (first inside current line, then inside
        -- neighborhood). One of: 'cover', 'cover_or_next', 'cover_or_prev',
        -- 'cover_or_nearest', 'next', 'prev', 'nearest'.
        search_method = "cover_or_next",
        
        -- Whether to disable showing non-error feedback
        silent = false,
      })
    end,
  },
  
  -- Highlight and search for todo comments
  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup({
        -- Keywords recognized as todo comments
        signs = true, -- Show icons in the signs column
        sign_priority = 8, -- Sign priority
        -- Keywords recognized as todo comments
        keywords = {
          FIX = {
            icon = " ", -- Icon used for the sign, and in search results
            color = "error", -- Can be a hex color, or a named color (see below)
            alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- Alternative keywords for the same group
            -- Signs, highlights and virtual text will be prefixed with this
            signs = false,
          },
          TODO = { icon = " ", color = "info" },
          HACK = { icon = " ", color = "warning" },
          WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
          PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
          NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
          TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
        },
        -- Merge keywords with the same color
        merge_keywords = true,
        -- Highlighting of the line containing the todo comment
        highlight = {
          -- Highlights only the keyword, not the whole line
          keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty
          -- Highlights after the keyword, until the end of line
          after = "fg", -- "fg" or "bg" or empty
          -- Pattern to match the whole line
          pattern = [[.*<(KEYWORDS)\s*:]], -- Pattern used for highlighting
          -- Uses treesitter to match the keyword
          comments_only = true, -- Highlight only inside comments using treesitter
          -- Max line length to highlight
          max_line_len = 400, -- Max line length to look for
          -- Exclude certain filetypes
          exclude = {}, -- List of file types to exclude highlighting
        },
        -- List of named colors
        colors = {
          error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
          warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
          info = { "DiagnosticInfo", "#2563EB" },
          hint = { "DiagnosticHint", "#10B981" },
          default = { "Identifier", "#7C3AED" },
          test = { "Identifier", "#FF00FF" },
        },
        -- Configuration for the search command
        search = {
          -- Match the keyword at word boundaries
          pattern = [[\b(KEYWORDS):]], -- ripgrep regex
          -- Adjust command options
          command = "rg",
          args = {
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
          },
          -- Filetypes to exclude from search
          -- Example: --glob=!test/**
          -- (see `rg --help glob` for more info)
          glob_pattern = nil,
        },
      })
      
      -- Keymaps for todo-comments
      vim.keymap.set("n", "]t", function()
        require("todo-comments").jump_next()
      end, { desc = "Next todo comment" })
      
      vim.keymap.set("n", "[t", function()
        require("todo-comments").jump_prev()
      end, { desc = "Previous todo comment" })
      
      -- Search todo comments
      vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todo comments" })
    end,
  },
  
  -- Highlight and navigate code using treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "windwp/nvim-ts-autotag",
      "JoosepAlviste/nvim-ts-context-commentstring",
      "RRethy/nvim-treesitter-endwise",
    },
    config = function()
      -- Configure treesitter
      require("nvim-treesitter.configs").setup({
        -- Install parsers automatically
        auto_install = true,
        -- List of parsers to install
        ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
          "html",
          "javascript",
          "json",
          "lua",
          "markdown",
          "markdown_inline",
          "python",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
        -- Enable syntax highlighting
        highlight = {
          enable = true,
          -- Disable for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          -- Enable additional vim regex highlighting for certain languages
          additional_vim_regex_highlighting = { "markdown" },
        },
        -- Enable incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = "<nop>",
            node_decremental = "<bs>",
          },
        },
        -- Enable indentation
        indent = { enable = true },
        -- Enable auto tag closing
        autotag = { enable = true },
        -- Enable auto end statements
        endwise = { enable = true },
        -- Enable context commentstring
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        -- Enable text objects
        textobjects = {
          -- Select text objects
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["al"] = "@loop.outer",
              ["il"] = "@loop.inner",
              ["ai"] = "@conditional.outer",
              ["ii"] = "@conditional.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["as"] = "@statement.outer",
              ["is"] = "@statement.inner",
              ["aC"] = "@comment.outer",
              ["iC"] = "@comment.inner",
            },
          },
          -- Move between text objects
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]a"] = "@parameter.outer",
              ["]l"] = "@loop.outer",
              ["]i"] = "@conditional.outer",
              ["]b"] = "@block.outer",
              ["]s"] = "@statement.outer",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
              ["]A"] = "@parameter.outer",
              ["]L"] = "@loop.outer",
              ["]I"] = "@conditional.outer",
              ["]B"] = "@block.outer",
              ["]S"] = "@statement.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[a"] = "@parameter.outer",
              ["[l"] = "@loop.outer",
              ["[i"] = "@conditional.outer",
              ["[b"] = "@block.outer",
              ["[s"] = "@statement.outer",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
              ["[A"] = "@parameter.outer",
              ["[L"] = "@loop.outer",
              ["[I"] = "@conditional.outer",
              ["[B"] = "@block.outer",
              ["[S"] = "@statement.outer",
            },
          },
          -- Swap text objects
          swap = {
            enable = true,
            swap_next = {
              ["<leader>sa"] = "@parameter.inner",
              ["<leader>sf"] = "@function.outer",
              ["<leader>sc"] = "@class.outer",
            },
            swap_previous = {
              ["<leader>sA"] = "@parameter.inner",
              ["<leader>sF"] = "@function.outer",
              ["<leader>sC"] = "@class.outer",
            },
          },
        },
      })
    end,
  },
  
  -- Better code folding
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "BufReadPost",
    config = function()
      -- Using ufo provider needs a large value of foldlevel
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      
      -- Using ufo folding provider
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          return { "treesitter", "indent" }
        end,
        fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
          local newVirtText = {}
          local suffix = ("  %d lines"):format(endLnum - lnum)
          local sufWidth = vim.fn.strdisplaywidth(suffix)
          local targetWidth = width - sufWidth
          local curWidth = 0
          
          for _, chunk in ipairs(virtText) do
            local chunkText = chunk[1]
            local chunkWidth = vim.fn.strdisplaywidth(chunkText)
            
            if targetWidth > curWidth + chunkWidth then
              table.insert(newVirtText, chunk)
            else
              chunkText = truncate(chunkText, targetWidth - curWidth)
              local hlGroup = chunk[2]
              table.insert(newVirtText, { chunkText, hlGroup })
              chunkWidth = vim.fn.strdisplaywidth(chunkText)
              
              -- str width returned from truncate() may less than 2nd argument, need padding
              if curWidth + chunkWidth < targetWidth then
                suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
              end
              break
            end
            curWidth = curWidth + chunkWidth
          end
          
          table.insert(newVirtText, { suffix, "MoreMsg" })
          return newVirtText
        end,
      })
      
      -- Keymaps for fold operations
      vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
      vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
      vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds, { desc = "Open folds except kinds" })
      vim.keymap.set("n", "zm", require("ufo").closeFoldsWith, { desc = "Close folds with" })
      vim.keymap.set("n", "zp", require("ufo").peekFoldedLinesUnderCursor, { desc = "Peek folded lines" })
    end,
  },
  
  -- Highlight matching words under cursor
  {
    "RRethy/vim-illuminate",
    event = "BufReadPost",
    config = function()
      require("illuminate").configure({
        -- Providers: provider used to get references in the buffer, ordered by priority
        providers = {
          "lsp",
          "treesitter",
          "regex",
        },
        -- Delay in milliseconds
        delay = 100,
        -- Filetype specific overrides.
        filetypes_denylist = {
          "dirbuf",
          "dirvish",
          "fugitive",
          "NvimTree",
          "TelescopePrompt",
          "TelescopeResults",
          "DressingInput",
          "alpha",
          "toggleterm",
        },
        -- Modes to illuminate in
        modes_allowlist = { "n" },
        -- Min/max width of highlight
        min_count_to_highlight = 1,
        -- Under cursor highlighting style
        under_cursor = true,
      })
      
      -- Keymaps for navigating between references
      vim.keymap.set("n", "]]", function()
        require("illuminate").goto_next_reference()
      end, { desc = "Next reference" })
      
      vim.keymap.set("n", "[[", function()
        require("illuminate").goto_prev_reference()
      end, { desc = "Previous reference" })
    end,
  },
  
  -- Highlight color codes with their actual color
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    config = function()
      require("colorizer").setup({
        filetypes = {
          "*", -- Highlight all files, but customize some others.
          cmp_docs = { always_update = true },
        },
        user_default_options = {
          RGB = true, -- #RGB hex codes
          RRGGBB = true, -- #RRGGBB hex codes
          names = false, -- "Name" codes like Blue or blue
          RRGGBBAA = true, -- #RRGGBBAA hex codes
          AARRGGBB = false, -- 0xAARRGGBB hex codes
          rgb_fn = true, -- CSS rgb() and rgba() functions
          hsl_fn = true, -- CSS hsl() and hsla() functions
          css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
          css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
          -- Available modes for `mode`: foreground, background,  virtualtext
          mode = "background", -- Set the display mode.
          -- Available methods are false / true / "normal" / "lsp" / "both"
          tailwind = true, -- Enable tailwind colors
          -- parsers can contain values used in |user_default_options|
          sass = { enable = true, parsers = { "css" }, }, -- Enable sass colors
          virtualtext = "■",
          -- update color values even if buffer is not focused
          always_update = false,
        },
        -- all the sub-options of filetypes apply to buftypes
        buftypes = {},
      })
    end,
  },
  
  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
    config = function()
      -- Configure indent-blankline
      require("ibl").setup({
        -- Indent line settings
        indent = {
          char = "│", -- Character to use for indent line
          tab_char = "│", -- Character to use for tab indent line
        },
        -- Scope settings
        scope = {
          enabled = true, -- Enable scope highlighting
          show_start = true, -- Show the start of the scope
          show_end = false, -- Don't show the end of the scope
          injected_languages = true, -- Show indent lines in injected languages
          highlight = { "Function", "Label" }, -- Highlight groups for scope
          priority = 500, -- Priority of the scope highlight
        },
        -- Exclude certain filetypes
        exclude = {
          filetypes = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "NvimTree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
          },
          buftypes = {
            "terminal",
            "nofile",
            "quickfix",
            "prompt",
          },
        },
      })
    end,
  },
  
  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup({
        -- Signs in the gutter
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "▁" },
          topdelete = { text = "▔" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        -- Integration with other plugins
        integrations = {
          diffview = true, -- Integration with diffview.nvim
        },
        -- Sign column settings
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        -- Attach to untracked files
        attach_to_untracked = true,
        -- Git blame settings
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        -- Status bar
        status_formatter = nil, -- Use default
        -- Update time
        update_debounce = 200,
        -- Use diff-so-fancy for diffs
        diff_opts = {
          internal = true, -- If luajit is present
        },
        -- Preview settings
        preview_config = {
          -- Options passed to nvim_open_win
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        -- Yadm support
        yadm = { enable = false },
        -- On attach function
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          
          -- Navigation
          vim.keymap.set("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Next hunk" })
          
          vim.keymap.set("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, buffer = bufnr, desc = "Previous hunk" })
          
          -- Actions
          -- Stage hunk
          vim.keymap.set({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { buffer = bufnr, desc = "Stage hunk" })
          -- Reset hunk
          vim.keymap.set({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { buffer = bufnr, desc = "Reset hunk" })
          -- Stage buffer
          vim.keymap.set("n", "<leader>hS", gs.stage_buffer, { buffer = bufnr, desc = "Stage buffer" })
          -- Undo stage hunk
          vim.keymap.set("n", "<leader>hu", gs.undo_stage_hunk, { buffer = bufnr, desc = "Undo stage hunk" })
          -- Reset buffer
          vim.keymap.set("n", "<leader>hR", gs.reset_buffer, { buffer = bufnr, desc = "Reset buffer" })
          -- Preview hunk
          vim.keymap.set("n", "<leader>hp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
          -- Blame line
          vim.keymap.set("n", "<leader>hb", function()
            gs.blame_line({ full = true })
          end, { buffer = bufnr, desc = "Blame line" })
          -- Toggle blame line
          vim.keymap.set("n", "<leader>htb", gs.toggle_current_line_blame, { buffer = bufnr, desc = "Toggle blame line" })
          -- Diff against index
          vim.keymap.set("n", "<leader>hd", gs.diffthis, { buffer = bufnr, desc = "Diff against index" })
          -- Diff against last commit
          vim.keymap.set("n", "<leader>hD", function()
            gs.diffthis("~")
          end, { buffer = bufnr, desc = "Diff against last commit" })
          -- Toggle deleted
          vim.keymap.set("n", "<leader>htd", gs.toggle_deleted, { buffer = bufnr, desc = "Toggle deleted" })
          -- Text object for hunks
          vim.keymap.set({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { buffer = bufnr, desc = "Select hunk" })
        end,
      })
    end,
  },
} 