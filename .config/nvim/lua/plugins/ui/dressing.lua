return {
	{
		"stevearc/dressing.nvim",
		event = { "VeryLazy" },
		opts = {
			input = {
				enabled = true,
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
	},
}
