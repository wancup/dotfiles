return {
	{
		"Wansmer/treesj",
		keys = {
			{ "<leader>tj", "<cmd>TSJJoin<cr>", desc = "[T]reeSJ [J]oin" },
			{ "<leader>ts", "<cmd>TSJSplit<cr>", desc = "[T]reeSJ [S]plit" },
			{ "<leader>t<leader>", "<cmd>TSJToggle<cr>", desc = "[T]reeSJ Toggle" },
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {
			use_default_keymaps = false,
		},
	},
}
