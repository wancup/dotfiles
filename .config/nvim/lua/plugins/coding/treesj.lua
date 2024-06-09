return {
	{
		"Wansmer/treesj",
		keys = {
			{ "<leader>jj", "<cmd>TSJJoin<cr>", desc = "TreeS[J] [J]oin" },
			{ "<leader>js", "<cmd>TSJSplit<cr>", desc = "TreeS[J] [S]plit" },
			{ "<leader>j<leader>", "<cmd>TSJToggle<cr>", desc = "TreeS[J] Toggle" },
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			use_default_keymaps = false,
		},
	},
}
