local wezterm = require "wezterm"

return {
  font = wezterm.font_with_fallback {
    { family = "UDEV Gothic 35JPDOC", assume_emoji_presentation = false },
    { family = "Noto Emoji",          weight = 700 },
  },
  font_size = 14,
  use_ime = true,
  unicode_version = 14,
  initial_cols = 160,
  initial_rows = 48,
  color_scheme = "Duotone Dark",
}
