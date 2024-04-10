return {
	{
		"ray-x/lsp_signature.nvim",
		event = {
			"BufReadPost",
			"BufNewFile",
		},
		opts = {
			bind = true,
			close_timeout = nil,
			handler_opts = {
				border = "rounded",
			},
			hint_enable = false,
			toggle_key = "<C-s>",
		},
	},
}
