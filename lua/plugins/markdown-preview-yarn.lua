-- markdown-preview-yarn.lua
-- Yarn-based configuration for Markdown preview functionality
-- Use this if the other markdown-preview configurations don't work

return {
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
  config = function()
    -- Set default browser to open preview (optional)
    vim.g.mkdp_browser = ''  -- Empty string means default browser
    
    -- Set to 1 to automatically open preview when entering a markdown buffer
    vim.g.mkdp_auto_start = 0
    
    -- Set to 1 to automatically close the current preview when leaving a markdown buffer
    vim.g.mkdp_auto_close = 1
    
    -- Refresh preview on buffer write or when leaving from insert mode
    vim.g.mkdp_refresh_slow = 0
    
    -- Set to 1 to echo preview page URL in command line when opening preview
    vim.g.mkdp_echo_preview_url = 1
    
    -- Preview page title
    vim.g.mkdp_page_title = '「${name}」'
    
    -- Add keymaps for markdown preview
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "markdown",
      callback = function()
        -- Local keymaps for markdown files
        vim.keymap.set("n", "<leader>mp", ":MarkdownPreview<CR>", 
          { buffer = true, desc = "Start markdown preview" })
        vim.keymap.set("n", "<leader>ms", ":MarkdownPreviewStop<CR>", 
          { buffer = true, desc = "Stop markdown preview" })
        vim.keymap.set("n", "<leader>mt", ":MarkdownPreviewToggle<CR>", 
          { buffer = true, desc = "Toggle markdown preview" })
      end,
    })
  end,
} 