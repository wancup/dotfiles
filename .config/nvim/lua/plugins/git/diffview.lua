-- Git Diff View
return {
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "[G]it [D]iff" },
			{ "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "[G]it Diff [C]lose" },
			{ "<leader>gl", "<cmd>DiffviewFileHistory %<cr>", desc = "[G]it [L]og Current File" },
			{ "<leader>gL", "<cmd>DiffviewFileHistory<cr>", desc = "[G]it [L]og" },
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
						{ "n", "<C-j>", actions.select_entry, { desc = "Open the diff for the selected entry." } },
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
						{ "n", "<C-j>", actions.select_entry, { desc = "Open the diff for the selected entry." } },
						{ "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
					},
				},
			})
		end,
	},
}
