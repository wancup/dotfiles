return {
	"linrongbin16/gitlinker.nvim",
	cmd = "GitLink",
	keys = {
		{ "<leader>gu", "<cmd>GitLink<cr>", mode = { "n", "v" }, desc = "Git Url Copy" },
		{ "<leader>gU", "<cmd>GitLink!<cr>", mode = { "n", "v" }, desc = "Git Url Open" },
	},
	config = true,
}
