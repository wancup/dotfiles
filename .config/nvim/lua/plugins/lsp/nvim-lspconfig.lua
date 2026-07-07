-- LSP
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "FormatByLsp", "Mason" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"b0o/schemastore.nvim",
	},
	keys = {
		{ "<leader>Ff", "<cmd>FormatByLsp<cr>", desc = "[F]ix [F]ormat Using LSP" },
	},
	config = function()
		require("mason-lspconfig").setup({
			ensure_installed = {},
		})
		vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
	end,
}
