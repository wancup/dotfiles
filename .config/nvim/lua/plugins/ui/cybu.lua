-- Buffer Cycle
return {
	"ghillb/cybu.nvim",
	cond = false,
	keys = {
		{ "<C-S-tab>", "<Plug>(CybuLastusedPrev)" },
		{ "<C-tab>", "<Plug>(CybuLastusedNext)" },
	},
	opts = {
		position = {
			relative_to = "win",
			anchor = "centerright",
		},
		behavior = {
			mode = {
				last_used = {
					switch = "immediate",
				},
			},
		},
		display_time = 2000,
	},
}
