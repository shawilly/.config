return { -- `:Telescope colorscheme` to check for installed themes
  'shawilly/monokai-nightasty.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  opts = {},
  init = function()
    vim.cmd.colorscheme 'monokai-nightasty'
    vim.cmd.hi 'Comment gui=none'
  end,
}
