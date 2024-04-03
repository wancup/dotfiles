-- Scrollbar
return {
	{
		"petertriho/nvim-scrollbar",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			hide_if_all_visible = true,
			handle = {
				blend = 10,
				color = "#323232",
			},
			marks = {
				Cursor = {
					color = "#666666",
				},
			},
			handlers = {
				cursor = false,
				gitsigns = true,
			},
		},
	},
}
