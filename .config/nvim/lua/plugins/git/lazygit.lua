return {
	{
		"kdheepak/lazygit.nvim",
		cmd = { "LazyGit", "LazyGitCurrentFile", "LazyGitConfig", "LazyGitFilter", "LazyGitFilterCurrentFile" },
		keys = {
			{ "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
			{ "<leader>gl", "<cmd>LazyGitFilterCurrentFile<cr>", desc = "[G]it [L]og Current File" },
		},
	},
}
