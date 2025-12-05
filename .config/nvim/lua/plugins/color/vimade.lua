return {
	"TaDaa/vimade",
	event = { "WinNew" },
	cmd = { "VimadeEnable" },
	opts = {
		recipe = { "default", { animate = false } },
		fadelevel = 0.5,
		usecursorhold = true,
	},
}
