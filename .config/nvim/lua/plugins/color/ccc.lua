-- Color Picker
return {
	"uga-rosa/ccc.nvim",
	ft = { "typescript", "typescriptreact", "html", "css" },
	cmd = { "CccPick", "CccConvert", "CccHighlighterEnable" },
	keys = {
		{ "<leader>uc", "<cmd>CccHighlighterToggle<cr>", desc = "[U]i [C]olor Highlight Toggle" },
		{ "<leader>cc", "<cmd>CccPick<cr>", desc = "[C]omand [C]olor" },
	},
	opts = {
		highlighter = {
			auto_enable = true,
		},
	},
}
