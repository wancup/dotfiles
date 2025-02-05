-- Git Diff View
return {
	"sindrets/diffview.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = {
		{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "[G]it [D]iff" },
		{ "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "[G]it [D]iff Close" },
	},
	config = function()
		local actions = require("diffview.actions")
		require("diffview").setup({
			keymaps = {
				view = {
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
				},
				file_panel = {
					{ "n", "<c-b>", false },
					{ "n", "<c-f>", false },
					{
						"n",
						"<PageUp>",
						actions.scroll_view(-0.25),
						{ desc = "Scroll the view up" },
					},
					{
						"n",
						"<PageDown>",
						actions.scroll_view(0.25),
						{ desc = "Scroll the view down" },
					},
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
				},
				file_history_panel = {
					{ "n", "<c-b>", false },
					{ "n", "<c-f>", false },
					{
						"n",
						"<PageUp>",
						actions.scroll_view(-0.25),
						{ desc = "Scroll the view up" },
					},
					{
						"n",
						"<PageDown>",
						actions.scroll_view(0.25),
						{ desc = "Scroll the view down" },
					},
					{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
				},
			},
		})
	end,
}
