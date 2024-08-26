return {
  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_assume_mapped = true

      -- Set the filetypes that you want to use copilot in
      vim.g.copilot_filetypes = {
        ["*"] = true,
      }

      -- Set the keybindings
      vim.keymap.set("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true, noremap = true, replace_keycodes = false })
      vim.keymap.set("i", "<C-j>", 'copilot#Next()', { silent = true, expr = true })
      vim.keymap.set("i", "<C-k>", 'copilot#Previous()', { silent = true, expr = true })
    end,
  },
}
