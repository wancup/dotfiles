-- LSP
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "FormatByLsp" },
	dependencies = {
		"b0o/schemastore.nvim",
	},
	keys = {
		{ "<leader>Ff", "<cmd>FormatByLsp<cr>", desc = "[F]ix [F]ormat Using LSP" },
	},
}
