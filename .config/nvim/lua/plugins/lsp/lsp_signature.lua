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
			always_trigger = true,
		},
	},
}
