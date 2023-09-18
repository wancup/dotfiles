-- Which Key
return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register({
				mode = { "n", "v" },
				["g"] = { name = "Goto" },
				["<leader><leader>"] = { name = "Window" },
				["<leader>b"] = { name = "Buffer" },
				["<leader>d"] = { name = "Diagnostics" },
				["<leader>f"] = { name = "Find" },
				["<leader>F"] = { name = "Fix" },
				["<leader>fg"] = { name = "Find Git" },
				["<leader>g"] = { name = "Git" },
				["<leader>gh"] = { name = "Git Hunk" },
				["<leader>gb"] = { name = "Git Buffer" },
				["<leader>l"] = { name = "Lazygit" },
				["<leader>L"] = { name = "List" },
				["<leader>n"] = { name = "Noice" },
				["<leader>N"] = { name = "Node.js" },
				["<leader>r"] = { name = "Replace" },
				["<leader>rb"] = { name = "ReplaceMultiBuffer" },
				["<leader>s"] = { name = "Surround" },
				["<leader>S"] = { name = "Session" },
			})
		end,
	},
}
