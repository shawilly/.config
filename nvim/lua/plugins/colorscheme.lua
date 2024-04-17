return {
  -- `:Telescope colorscheme` to check for installed themes
  'loctvl842/monokai-pro.nvim',
  opts = {
    transparent_background = true,
    devicons = true, -- highlight the icons of `nvim-web-devicons`
    filter = 'pro',
  },
  -- classic | octagon | pro | machine | ristretto | spectrum
  priority = 1000, -- Make sure to load this before all the other start plugins.
  init = function()
    vim.cmd.colorscheme 'monokai-pro'
    -- You can configure highlights by doing something like:
    vim.cmd.hi 'Comment gui=none'
  end,
}
