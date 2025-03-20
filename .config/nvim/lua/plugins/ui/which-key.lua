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
				{ "<leader>b", group = "Buffer" },
				{ "<leader>c", group = "Command" },
				{ "<leader>ct", group = "Command Text-Case" },
				{ "<leader>f", group = "Find" },
				{ "<leader>F", group = "Fix" },
				{ "<leader>fg", group = "Find Git" },
				{ "<leader>g", group = "Git" },
				{ "<leader>gh", group = "Git Hunk" },
				{ "<leader>gb", group = "Git Buffer" },
				{ "<leader>j", group = "TreeSJ" },
				{ "<leader>l", group = "List" },
				{ "<leader>n", group = "Noice" },
				{ "<leader>N", group = "Node.js" },
				{ "<leader>s", group = "Surround" },
				{ "<leader>S", group = "Session" },
				{ "<leader>t", group = "Test" },
				{ "<leader>u", group = "UI" },
			},
		})
	end,
}
