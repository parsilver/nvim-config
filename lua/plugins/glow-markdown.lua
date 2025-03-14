-- glow-markdown.lua
-- Alternative markdown preview using glow.nvim
-- Use this if markdown-preview.nvim doesn't work

return {
  "ellisonleao/glow.nvim",
  config = function()
    require("glow").setup({
      -- Glow binary path
      glow_path = "", -- Default: will look in PATH
      -- Style of the markdown preview
      border = "rounded", -- "single", "double", "rounded", "solid", "shadow", "none"
      -- Width of the window
      width = 120,
      -- Height of the window
      height = 100,
      -- Width of the window in %
      width_ratio = 0.7,
      -- Height of the window in %
      height_ratio = 0.7,
    })
    
    -- Add keymaps for markdown preview
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        -- Local keymaps for markdown files
        vim.keymap.set("n", "<leader>mp", ":Glow<CR>", 
          { buffer = true, desc = "Preview markdown with Glow" })
      end,
    })
  end,
  cmd = { "Glow" },
  ft = { "markdown" },
} 