return {
	{
		"echasnovski/mini.files",
		version = false,
		keys = {
			{
				"<leader>E",
				function()
					local current_buf = vim.api.nvim_buf_get_name(0)
					require("mini.files").open(current_buf)
					require("mini.files").reveal_cwd()
				end,
				desc = "[E]xplore files",
			},
		},
		opts = {
			mappings = {
				go_in = "",
				go_in_plus = "L",
				go_out = "",
				go_out_plus = "H",
				reveal_cwd = "",
			},
			options = {
				use_as_default_explorer = false,
			},
			windows = {
				preview = true,
				width_focus = 40,
				width_preview = 50,
			},
		},
	},
}
