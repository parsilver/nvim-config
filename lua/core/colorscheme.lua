-- colorscheme.lua
-- Colorscheme configuration

-- Set the colorscheme with error handling
local function set_colorscheme()
  -- Default colorscheme as fallback
  local default_colorscheme = "tokyonight"
  
  -- Check if the colorscheme plugin is available
  local has_colorscheme, _ = pcall(require, "tokyonight")
  
  if has_colorscheme then
    -- Configure the colorscheme
    require("tokyonight").setup({
      style = "storm", -- Options: storm, moon, night, day
      transparent = false,
      terminal_colors = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
      },
    })
  end
  
  -- Try to set the colorscheme
  local status_ok, _ = pcall(vim.cmd, "colorscheme " .. default_colorscheme)
  
  -- If the colorscheme couldn't be found, set a built-in one
  if not status_ok then
    vim.notify("Colorscheme " .. default_colorscheme .. " not found! Using default.", vim.log.levels.WARN)
    vim.cmd("colorscheme habamax") -- Fallback to a built-in colorscheme
  end
end

set_colorscheme() 