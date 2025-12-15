return {
	"wancup/tabycle.nvim",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>bl",
			function()
				require("tabycle").toggle_list()
			end,
		},
		{
			"<leader>bs",
			function()
				require("tabycle").toggle_summary()
			end,
		},
		{
			"<C-tab>",
			function()
				require("tabycle").cycle_buffer_back()
			end,
		},
		{
			"<C-S-tab>",
			function()
				require("tabycle").cycle_buffer_forward()
			end,
		},
	},
	opts = {
		cycle = {
			keymaps = {
				open_vsplit = "<C-S-s>",
			},
		},
		summary = {
			win = {
				row = 1,
			},
		},
	},
}
