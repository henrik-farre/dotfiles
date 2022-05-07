local wezterm = require 'wezterm';
return {
  font = wezterm.font("mononoki Nerd Font"),
  font_size = 10,
  -- color_scheme = "Tango Adapted",
  colors = {
    foreground = "silver",
    background = "black",
  },
  hide_tab_bar_if_only_one_tab = true,
  default_cursor_style = "BlinkingBlock",
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  }
}
