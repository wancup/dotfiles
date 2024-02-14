return {
	{
		"echasnovski/mini.files",
		version = false,
		keys = {
			{
				"<leader>e",
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
				go_in_plus = "l",
				go_out = "",
				go_out_plus = "h",
			},
			options = {
				use_as_default_explorer = false,
			},
		},
	},
}
