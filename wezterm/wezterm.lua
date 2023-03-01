local wezterm = require "wezterm"

return {
    font = wezterm.font_with_fallback {
        { family = 'HackGen35 Console', assume_emoji_presentation = false },
        { family = "Noto Emoji",        weight = 700 },
    },
    use_ime = true,
    font_size = 14,
    unicode_version = 14,
    initial_cols = 160,
    initial_rows = 48,
    color_scheme = "Duotone Dark",
}
