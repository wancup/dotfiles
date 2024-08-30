-- Color Picker
return {
	{
		"uga-rosa/ccc.nvim",
		cmd = { "CccPick", "CccConvert", "CccHighlighterEnable" },
		keys = {
			{ "<leader>uc", "<cmd>CccHighlighterToggle<cr>", desc = "[U]i [C]olor Highlight Toggle" },
		},
		opts = {},
	},
}
