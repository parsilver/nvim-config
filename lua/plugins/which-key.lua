-- which-key.lua
-- Configuration for which-key plugin

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  config = function()
    local wk = require("which-key")
    
    -- Basic setup with minimal options
    wk.setup({
      window = {
        border = "single",
      },
    })
    
    -- Register key groups
    wk.register({
      ["<leader>f"] = { name = "Find (Telescope)" },
      ["<leader>g"] = { name = "Git" },
      ["<leader>h"] = { name = "Git Hunks" },
      ["<leader>b"] = { name = "Buffers" },
      ["<leader>s"] = { name = "Split Windows" },
      ["<leader>t"] = { name = "Tabs/Terminal/Toggle" },
      ["<leader>w"] = { name = "Write" },
      ["<leader>q"] = { name = "Quit" },
      ["<leader>l"] = { name = "LSP" },
      ["<leader>m"] = { name = "Markdown" },
    })
    
    -- Register specific keymaps for toggles
    wk.register({
      ["<leader>ti"] = { desc = "Toggle indent lines" },
      ["<leader>ts"] = { desc = "Toggle scope highlighting" },
      ["<leader>tb"] = { desc = "Toggle line blame" },
      ["<leader>td"] = { desc = "Toggle deleted" },
      ["<leader>tt"] = { desc = "Open terminal" },
    })
    
    -- Register buffer keymaps
    wk.register({
      ["<leader>bp"] = { desc = "Previous buffer" },
      ["<leader>bn"] = { desc = "Next buffer" },
      ["<leader>bc"] = { desc = "Pick buffer to close" },
      ["<leader>bb"] = { desc = "Pick buffer" },
      ["<leader>bs"] = { desc = "Sort buffers by directory" },
      ["<leader>bt"] = { desc = "Sort buffers by tabs" },
      ["<leader>bd"] = { desc = "Delete current buffer" },
    })
    
    -- Register number keys for buffer navigation
    wk.register({
      ["<leader>1"] = { desc = "Go to buffer 1" },
      ["<leader>2"] = { desc = "Go to buffer 2" },
      ["<leader>3"] = { desc = "Go to buffer 3" },
      ["<leader>4"] = { desc = "Go to buffer 4" },
      ["<leader>5"] = { desc = "Go to buffer 5" },
      ["<leader>6"] = { desc = "Go to buffer 6" },
      ["<leader>7"] = { desc = "Go to buffer 7" },
      ["<leader>8"] = { desc = "Go to buffer 8" },
      ["<leader>9"] = { desc = "Go to buffer 9" },
      ["<leader>$"] = { desc = "Go to last buffer" },
    })
    
    -- Register markdown preview keymaps (only active in markdown files)
    wk.register({
      ["<leader>mp"] = { desc = "Start markdown preview" },
      ["<leader>ms"] = { desc = "Stop markdown preview" },
      ["<leader>mt"] = { desc = "Toggle markdown preview" },
    }, { ft = "markdown" })
  end,
} 