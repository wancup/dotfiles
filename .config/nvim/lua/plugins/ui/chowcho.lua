return {
	"tkmpypy/chowcho.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{
			"<leader><leader>P",
			function()
				require("chowcho").run()
			end,
			desc = "[P]ick Window with file name",
		},
		{
			"<leader><leader>C",
			function()
				require("chowcho").run(vim.api.nvim_win_hide)
			end,
			desc = "[C]lose Window with file name",
		},
	},
	opts = {
		icon_enabled = true,
		active_border_color = "#eb6f92",
		border_style = "rounded",
	},
}
