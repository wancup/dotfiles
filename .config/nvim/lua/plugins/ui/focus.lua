return {
	"nvim-focus/focus.nvim",
	version = "*",
	event = { "WinNew" },
	opts = {
		enable = true,
		autoresize = {
			enable = true,
		},
		ui = {
			number = true,
			relativenumber = true,
			hybridnumber = true,
		},
	},
}
