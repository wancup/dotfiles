return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		plugins = { spelling = true },
	},
	config = function(_, opts)
		local wk = require("which-key")
		wk.setup(opts)
		wk.add({
			{
				mode = { "n", "v" },
				{ "g", group = "Goto" },
				{ "<leader>a", group = "AI" },
				{ "<leader>b", group = "Buffer" },
				{ "<leader>c", group = "Command" },
				{ "<leader>f", group = "Find" },
				{ "<leader>F", group = "Fix" },
				{ "<leader>fg", group = "Find Git" },
				{ "<leader>g", group = "Git" },
				{ "<leader>gh", group = "Git Hunk" },
				{ "<leader>gb", group = "Git Buffer" },
				{ "<leader>j", group = "TreeSJ" },
				{ "<leader>l", group = "List" },
				{ "<leader>m", group = "Terminal" },
				{ "<leader>n", group = "Noice" },
				{ "<leader>N", group = "Node.js" },
				{ "<leader>r", group = "Rename" },
				{ "<leader>s", group = "Surround" },
				{ "<leader>S", group = "Session" },
				{ "<leader>t", group = "Test and Tab" },
				{ "<leader>u", group = "UI" },
			},
		})
	end,
}
