return {
	"Wansmer/treesj",
	keys = {
		{ "<leader>jj", "<cmd>TSJJoin<cr>", desc = "TreeSJ [J]oin" },
		{ "<leader>js", "<cmd>TSJSplit<cr>", desc = "TreeSJ [S]plit" },
		{ "<leader>j<leader>", "<cmd>TSJToggle<cr>", desc = "TreeSJ Toggle" },
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		use_default_keymaps = false,
	},
}
