return {
	"stevearc/dressing.nvim",
	event = { "VeryLazy" },
	opts = {
		input = {
			enabled = true,
			win_options = {
				listchars = "precedes:-,extends:-",
			},
		},
		select = {
			enabled = true,
			backend = { "builtin", "telescope", "fzf_lua", "fzf", "nui" },
			builtin = {
				mappings = {
					["q"] = "Close",
				},
			},
		},
	},
}
