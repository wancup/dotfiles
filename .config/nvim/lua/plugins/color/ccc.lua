-- Color Picker
return {
	"uga-rosa/ccc.nvim",
	ft = { "typescript", "typescriptreact", "html", "css" },
	cmd = { "CccPick", "CccConvert", "CccHighlighterEnable" },
	keys = {
		{ "<leader>uc", "<cmd>CccHighlighterToggle<cr>", desc = "[U]i [C]olor Highlight Toggle" },
	},
	opts = {
		highlighter = {
			auto_enable = true,
		},
	},
}
