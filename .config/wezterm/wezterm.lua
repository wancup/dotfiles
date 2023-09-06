local wezterm = require("wezterm")
local act = wezterm.action

local config = {
	font = wezterm.font_with_fallback({
		{ family = "UDEV Gothic 35JPDOC", assume_emoji_presentation = false },
		{ family = "Noto Emoji", weight = 700 },
	}),
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
	disable_default_key_bindings = true,
	keys = {
		{ key = "Enter", mods = "ALT", action = act.ToggleFullScreen },
		{ key = "s", mods = "SUPER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "S", mods = "SUPER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "+", mods = "SUPER", action = act.IncreaseFontSize },
		{ key = "-", mods = "SUPER", action = act.DecreaseFontSize },
		{ key = "0", mods = "SUPER", action = act.ResetFontSize },
		{ key = "1", mods = "SUPER", action = act.ActivateTab(0) },
		{ key = "2", mods = "SUPER", action = act.ActivateTab(1) },
		{ key = "3", mods = "SUPER", action = act.ActivateTab(2) },
		{ key = "4", mods = "SUPER", action = act.ActivateTab(3) },
		{ key = "5", mods = "SUPER", action = act.ActivateTab(4) },
		{ key = "6", mods = "SUPER", action = act.ActivateTab(5) },
		{ key = "7", mods = "SUPER", action = act.ActivateTab(6) },
		{ key = "8", mods = "SUPER", action = act.ActivateTab(7) },
		{ key = "9", mods = "SUPER", action = act.ActivateTab(-1) },
		{ key = "[", mods = "SUPER", action = act.ActivateTabRelative(-1) },
		{ key = "]", mods = "SUPER", action = act.ActivateTabRelative(1) },
		{ key = "c", mods = "SUPER", action = act.CopyTo("Clipboard") },
		{ key = "f", mods = "SUPER", action = act.Search("CurrentSelectionOrEmptyString") },
		{ key = "h", mods = "SUPER", action = act.HideApplication },
		{ key = "k", mods = "SUPER", action = act.ClearScrollback("ScrollbackOnly") },
		{ key = "l", mods = "SUPER", action = act.ShowDebugOverlay },
		{ key = "m", mods = "SUPER", action = act.Hide },
		{ key = "n", mods = "SUPER", action = act.SpawnWindow },
		{ key = "p", mods = "SUPER", action = act.ActivateCommandPalette },
		{ key = "q", mods = "SUPER", action = act.QuitApplication },
		{ key = "r", mods = "SUPER", action = act.ReloadConfiguration },
		{ key = "t", mods = "SUPER", action = act.SpawnTab("CurrentPaneDomain") },
		{
			key = "u",
			mods = "SUPER",
			action = act.CharSelect({ copy_on_select = true, copy_to = "ClipboardAndPrimarySelection" }),
		},
		{ key = "v", mods = "SUPER", action = act.PasteFrom("Clipboard") },
		{ key = "w", mods = "SUPER", action = act.CloseCurrentTab({ confirm = true }) },
		{ key = "x", mods = "SUPER", action = act.QuickSelect },
		{ key = "X", mods = "SUPER", action = act.ActivateCopyMode },
		{ key = "z", mods = "SUPER", action = act.TogglePaneZoomState },
		{ key = "LeftArrow", mods = "SUPER", action = act.ActivatePaneDirection("Left") },
		{ key = "RightArrow", mods = "SUPER", action = act.ActivatePaneDirection("Right") },
		{ key = "UpArrow", mods = "SUPER", action = act.ActivatePaneDirection("Up") },
		{ key = "DownArrow", mods = "SUPER", action = act.ActivatePaneDirection("Down") },
		{ key = "Copy", mods = "NONE", action = act.CopyTo("Clipboard") },
		{ key = "Paste", mods = "NONE", action = act.PasteFrom("Clipboard") },
	},
	key_tables = {
		copy_mode = {
			{ key = "Tab", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{ key = "Tab", mods = "SHIFT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "Space", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },
			{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
			{ key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "T", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
			{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
			{ key = "c", mods = "CTRL", action = act.CopyMode("Close") },
			{ key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },
			{ key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },
			{ key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
			{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
			{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "q", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "t", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
			{ key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
			{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },
			{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),
			},
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },
			{ key = "End", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = "LeftArrow", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "LeftArrow", mods = "ALT", action = act.CopyMode("MoveBackwardWord") },
			{ key = "RightArrow", mods = "NONE", action = act.CopyMode("MoveRight") },
			{ key = "RightArrow", mods = "ALT", action = act.CopyMode("MoveForwardWord") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("MoveDown") },
		},
		search_mode = {
			{ key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "n", mods = "CTRL", action = act.CopyMode("NextMatch") },
			{ key = "p", mods = "CTRL", action = act.CopyMode("PriorMatch") },
			{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
			{ key = "u", mods = "CTRL", action = act.CopyMode("ClearPattern") },
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PriorMatchPage") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("NextMatchPage") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("NextMatch") },
		},
	},
}

if wezterm.target_triple == "aarch64-apple-darwin" then
	config.default_prog = { "/opt/homebrew/bin/fish", "-l" }
	config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"
end

return config
