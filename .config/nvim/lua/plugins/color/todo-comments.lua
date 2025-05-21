-- TODO comment
return {
	"folke/todo-comments.nvim",
	cmd = { "TodoTrouble", "TodoTelescope" },
	event = { "BufReadPost", "BufNewFile" },
	config = true,
	keys = {
		{ "<leader>lt", "<cmd>TodoQuickFix<cr>", desc = "List Todo" },
		{ "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find Todos" },
	},
}
