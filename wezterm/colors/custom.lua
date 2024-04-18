-- A slightly altered version of catppucchin mocha
local mocha = {
   rosewater = '#D9C2B6',
   flamingo = '#D3B2AE',
   pink = '#D6A7C1',
   mauve = '#B194CB',
   red = '#D58C9D',
   maroon = '#C899A0',
   peach = '#E1A46E',
   yellow = '#DFD1A1',
   green = '#88C98B',
   teal = '#6DC6BB',
   sky = '#72B6C8',
   sapphire = '#5CA0C9',
   blue = '#7AA5DC',
   lavender = '#A0A4DF',
   text = '#9EA7D8',
   subtext1 = '#8D92C5',
   subtext0 = '#7B80B2',
   overlay2 = '#666C80',
   overlay1 = '#535769',
   overlay0 = '#404453',
   surface2 = '#313540',
   surface1 = '#252632',
   surface0 = '#1A1A24',
   base = '#0F0F14',
   mantle = '#0D0D10',
   crust = '#09090F',
}

local colorscheme = {
   foreground = mocha.text,
   background = mocha.base,
   cursor_bg = mocha.rosewater,
   cursor_border = mocha.rosewater,
   cursor_fg = mocha.crust,
   selection_bg = mocha.surface2,
   selection_fg = mocha.text,
   ansi = {
      '#2D2D2D', -- black
      '#A83E3E', -- red
      '#4BAE4B', -- green
      '#BFAE3D', -- yellow
      '#4C6BC5', -- blue
      '#8D55A3', -- magenta/purple
      '#539AC8', -- cyan
      '#AFAFAF', -- white
   },
   brights = {
      '#7C7C7C', -- black
      '#E16F72', -- red
      '#5CC45D', -- green
      '#FFF6C6', -- yellow
      '#7493FF', -- blue
      '#C962BE', -- magenta/purple
      '#85E6E6', -- cyan
      '#E5E5E5', -- white
   },
   tab_bar = {
      background = 'rgba(0, 0, 0, 0.4)',
      active_tab = {
         bg_color = mocha.surface2,
         fg_color = mocha.text,
      },
      inactive_tab = {
         bg_color = mocha.surface0,
         fg_color = mocha.subtext1,
      },
      inactive_tab_hover = {
         bg_color = mocha.surface0,
         fg_color = mocha.text,
      },
      new_tab = {
         bg_color = mocha.base,
         fg_color = mocha.text,
      },
      new_tab_hover = {
         bg_color = mocha.mantle,
         fg_color = mocha.text,
         italic = true,
      },
   },
   visual_bell = mocha.surface0,
   indexed = {
      [16] = mocha.peach,
      [17] = mocha.rosewater,
   },
   scrollbar_thumb = mocha.surface2,
   split = mocha.overlay0,
   compose_cursor = mocha.flamingo, -- nightbuild only
}

return colorscheme
