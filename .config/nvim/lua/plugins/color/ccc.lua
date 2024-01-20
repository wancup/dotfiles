-- Color Picker
return {
	{
		"uga-rosa/ccc.nvim",
		cmd = { "CccPick", "CccConvert", "CccHighlighterEnable" },
		keys = {
			{ "<leader>cp", "<cmd>CccPick<cr>", desc = "[C]olor [P]icker" },
			{ "<leader>ch", "<cmd>CccHighlighterToggle<cr>", desc = "[C]olor [H]ighlight Toggle" },
		},
		opts = {},
	},
}
