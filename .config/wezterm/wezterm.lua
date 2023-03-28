local wezterm = require "wezterm"

local config = {
  font = wezterm.font_with_fallback {
    { family = "UDEV Gothic 35JPDOC", assume_emoji_presentation = false },
    { family = "Noto Emoji",          weight = 700 },
  },
  font_size = 14,
  use_ime = true,
  unicode_version = 14,
  initial_cols = 160,
  initial_rows = 48,
  color_scheme = "tokyonight_night",
  audible_bell = "Disabled",
  colors = {
    cursor_bg = "#524f67",
    cursor_fg = "#e0def4",
    cursor_border = "#524f67",
  },
}

if wezterm.target_triple == "aarch64-apple-darwin" then
  config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
end

return config
