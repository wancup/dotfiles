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
				["<leader>c"] = { name = "Color" },
				["<leader>f"] = { name = "Find" },
				["<leader>F"] = { name = "Fix" },
				["<leader>fg"] = { name = "Find Git" },
				["<leader>g"] = { name = "Git" },
				["<leader>gh"] = { name = "Git Hunk" },
				["<leader>gb"] = { name = "Git Buffer" },
				["<leader>j"] = { name = "TreeSJ" },
				["<leader>l"] = { name = "List" },
				["<leader>n"] = { name = "Noice" },
				["<leader>N"] = { name = "Node.js" },
				["<leader>r"] = { name = "Replace" },
				["<leader>rb"] = { name = "ReplaceMultiBuffer" },
				["<leader>s"] = { name = "Surround" },
				["<leader>S"] = { name = "Session" },
				["<leader>u"] = { name = "UI" },
			})
		end,
	},
}
