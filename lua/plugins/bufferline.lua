-- bufferline.lua
-- Configuration for beautiful buffer/tab line

return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    -- Load the bufferline plugin
    local bufferline = require("bufferline")
    
    -- Configure the plugin with nice defaults
    bufferline.setup({
      options = {
        -- Style options
        mode = "buffers", -- Set to "tabs" if you prefer tabs only
        style_preset = bufferline.style_preset.default,
        themable = true,
        
        -- Buffer display options
        numbers = "ordinal", -- Show buffer numbers
        indicator = {
          icon = "▎", -- The indicator icon
          style = "icon",
        },
        
        -- Buffer filtering and sorting
        buffer_close_icon = "󰅖",
        modified_icon = "●",
        close_icon = "",
        left_trunc_marker = "",
        right_trunc_marker = "",
        
        -- Tab behavior
        tab_size = 18,
        max_name_length = 18,
        truncate_names = true, -- Whether or not to truncate tab names
        
        -- Separators
        separator_style = "thin", -- "slant" | "thick" | "thin" | { 'any', 'any' }
        
        -- Diagnostics integration
        diagnostics = "nvim_lsp",
        diagnostics_update_in_insert = false,
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        
        -- Offsets for file explorer
        offsets = {
          {
            filetype = "NvimTree",
            text = "File Explorer",
            text_align = "center",
            separator = true,
          }
        },
        
        -- Hover actions
        hover = {
          enabled = true,
          delay = 200,
          reveal = {'close'}
        },
        
        -- Additional options
        color_icons = true, -- Whether or not to add the filetype icon
        show_buffer_icons = true, -- Disable filetype icons for buffers
        show_buffer_close_icons = true,
        show_close_icon = true,
        show_tab_indicators = true,
        persist_buffer_sort = true, -- Whether or not custom sorted buffers should persist
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        sort_by = "id",
      }
    })
    
    -- Keymaps for navigating buffers
    vim.keymap.set("n", "<leader>bp", ":BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
    vim.keymap.set("n", "<leader>bn", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "<leader>bc", ":BufferLinePickClose<CR>", { desc = "Pick buffer to close" })
    vim.keymap.set("n", "<leader>bb", ":BufferLinePick<CR>", { desc = "Pick buffer" })
    vim.keymap.set("n", "<leader>bs", ":BufferLineSortByDirectory<CR>", { desc = "Sort buffers by directory" })
    vim.keymap.set("n", "<leader>bt", ":BufferLineSortByTabs<CR>", { desc = "Sort buffers by tabs" })
    vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete current buffer" })
    
    -- Tab navigation
    vim.keymap.set("n", "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", { desc = "Go to buffer 1" })
    vim.keymap.set("n", "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", { desc = "Go to buffer 2" })
    vim.keymap.set("n", "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", { desc = "Go to buffer 3" })
    vim.keymap.set("n", "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", { desc = "Go to buffer 4" })
    vim.keymap.set("n", "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", { desc = "Go to buffer 5" })
    vim.keymap.set("n", "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", { desc = "Go to buffer 6" })
    vim.keymap.set("n", "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", { desc = "Go to buffer 7" })
    vim.keymap.set("n", "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", { desc = "Go to buffer 8" })
    vim.keymap.set("n", "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", { desc = "Go to buffer 9" })
    vim.keymap.set("n", "<leader>$", "<Cmd>BufferLineGoToBuffer -1<CR>", { desc = "Go to last buffer" })
  end,
} 