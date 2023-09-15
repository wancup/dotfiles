-- TODO comment
return {
	{
		"folke/todo-comments.nvim",
		cmd = { "TodoTrouble", "TodoTelescope" },
		event = { "BufReadPost", "BufNewFile" },
		config = true,
		keys = {
			{ "<leader>tL", "<cmd>TodoTrouble<cr>", desc = "[T]odo [L]ist" },
			{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "[F]ind [T]odos" },
		},
	},
}
