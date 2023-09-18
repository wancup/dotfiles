-- Buffer Cycle
return {
	"ghillb/cybu.nvim",
	keys = {
		{ "<C-S-tab>", "<Plug>(CybuLastusedPrev)" },
		{ "<C-tab>", "<Plug>(CybuLastusedNext)" },
	},
	opts = {
		position = {
			relative_to = "win",
			anchor = "topright",
		},
		behavior = {
			mode = {
				last_used = {
					switch = "immediate",
				},
			},
		},
		display_time = 500,
	},
}
