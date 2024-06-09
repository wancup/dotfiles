return {
	{
		"linrongbin16/gitlinker.nvim",
		cmd = "GitLink",
		keys = {
			{ "<leader>gu", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "[G]it [U]rl Copy" },
			{ "<leader>gU", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "[G]it [U]rl Open" },
		},
		config = true,
	},
}
