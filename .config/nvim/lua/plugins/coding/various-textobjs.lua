return {
	"chrisgrieser/nvim-various-textobjs",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		keymaps = {
			useDefaults = true,
			disabledDefaults = {
				"r",
			},
		},
	},
}
