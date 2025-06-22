-- Color Picker
return {
	"uga-rosa/ccc.nvim",
	ft = { "typescript", "typescriptreact", "html", "css" },
	cmd = { "CccPick", "CccConvert", "CccHighlighterEnable" },
	keys = {
		{ "<leader>uc", "<cmd>CccHighlighterToggle<cr>", desc = "[U]i [C]olor Highlight Toggle" },
		{ "<leader>cc", "<cmd>CccPick<cr>", desc = "[C]omand [C]olor" },
	},
	config = function()
		require("ccc").setup({
			highlighter = {
				auto_enable = true,
			},
			inputs = {
				require("ccc.input.oklch"),
				require("ccc.input.hsl"),
				require("ccc.input.rgb"),
				require("ccc.input.cmyk"),
			},
			outputs = {
				require("ccc.output.css_oklch"),
				require("ccc.output.css_hsl"),
				require("ccc.output.css_rgb"),
				require("ccc.output.hex"),
				require("ccc.output.hex_short"),
			},
		})
	end,
}
