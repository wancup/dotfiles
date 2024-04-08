-- Noice
return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				signature = {
					enabled = false,
				},
			},
			presets = {
				bottom_search = true,
				long_message_to_split = true,
				inc_rename = false,
				lsp_doc_border = true,
			},
			routes = {
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
			},
		},
		keys = {
			{
				"<leader>nm",
				function()
					require("noice").cmd("last")
				end,
				desc = "[N]oice Last [M]essage",
			},
			{
				"<leader>nh",
				function()
					require("noice").cmd("history")
				end,
				desc = "[N]oice [H]istory",
			},
		},
	},
}
