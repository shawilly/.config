return {
  -- `:Telescope colorscheme` to check for installed themes
  'shawilly/dunish.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  opts = {
    transparent = true,
  },
  init = function()
    vim.cmd.colorscheme 'dunish'
    vim.cmd.hi 'Comment gui=none'
  end,
}
