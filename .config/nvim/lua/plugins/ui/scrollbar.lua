-- Scrollbar
return {
	{
		"petertriho/nvim-scrollbar",
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			{ "<leader>us", "<cmd>ScrollbarToggle<cr>", desc = "[U]I [S]crollbar Toggle" },
		},
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
				GitDelete = {
					text = ".",
					highlight = "GitSignsChange",
				},
			},
			handlers = {
				cursor = false,
				gitsigns = true,
			},
		},
	},
}
