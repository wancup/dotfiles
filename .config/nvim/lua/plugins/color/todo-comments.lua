-- TODO comment
return {
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
		keys = {
			{ "<leader>lt", "<cmd>TodoQuickFix<cr>", desc = "[L]ist [T]odo" },
			{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "[F]ind [T]odos" },
		},
	},
}
