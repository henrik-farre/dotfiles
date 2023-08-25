local wezterm = require 'wezterm';

local base_scheme = "Tango (terminal.sexy)"
local custom_scheme = wezterm.color.get_builtin_schemes()[base_scheme]
-- custom_scheme.colors.ansi = {
--   '#121212',
--   '#ae3232',
--   '#5b762f',
--   '#aa9943',
--   '#324c80',
--   '#5f5a90',
--   '#92b19e',
--   '#ffffff',
-- }

-- custom_scheme.colors.brights = {
--   '#474747',
--   '#cb2b2b',
--   '#89b83f',
--   '#efef60',
--   '#2b4f98',
--   '#826ab1',
--   '#a1cdcd',
--   '#dedede',
-- }

return {
  font = wezterm.font("mononoki Nerd Font"),
  enable_wayland = true,
  font_size = 11,
  hide_tab_bar_if_only_one_tab = true,
  default_cursor_style = "BlinkingBlock",
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  colors = {
    ansi = {
      '#121212',
      '#ae3232',
      '#5b762f',
      '#aa9943',
      '#324c80',
      '#5f5a90',
      '#92b19e',
      '#ffffff',
    },
    background = '#000000',
    brights = {
      '#474747',
      '#cb2b2b',
      '#89b83f',
      '#efef60',
      '#2b4f98',
      '#826ab1',
      '#a1cdcd',
      '#dedede',
    },
    cursor_bg = '#bfceff',
    cursor_border = '#bfceff',
    cursor_fg = '#383a42',
    foreground = '#ffffff',
    selection_bg = '#bfceff',
    selection_fg = '#383a42',
    },

}
