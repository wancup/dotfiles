return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	opts = {
		highlight = { enable = true },
		indent = { enable = true },
		ensure_installed = {
			"vimdoc",
			"bash",
			"css",
			"html",
			"javascript",
			"json",
			"lua",
			"markdown",
			"markdown_inline",
			"terraform",
			"tsx",
			"typescript",
			"vim",
			"yaml",
		},
		incremental_selection = {
			enable = false,
		},

		textobjects = {
			select = {
				enable = true,
				lookahead = false,
				keymaps = {
					["ia"] = "@attribute.inner",
					["aa"] = "@attribute.outer",
					["iA"] = "@assignment.inner",
					["aA"] = "@assignment.outer",
					["ib"] = "@block.inner",
					["ab"] = "@block.outer",
					["iC"] = "@class.inner",
					["aC"] = "@class.outer",
					["ic"] = "@call.inner",
					["ac"] = "@call.outer",
					["i/"] = "@comment.inner",
					["a/"] = "@comment.outer",
					["i="] = "@conditional.inner",
					["a="] = "@conditional.outer",
					["if"] = "@function.inner",
					["af"] = "@function.outer",
					["il"] = "@function.loop",
					["al"] = "@function.loop",
					["ip"] = "@parameter.inner",
					["ap"] = "@parameter.outer",
				},
			},
			move = {
				enable = true,
				goto_next_start = {
					["]="] = "@conditional.outer",
					["]f"] = "@function.outer",
				},
				goto_next_end = {
					["]+"] = "@conditional.outer",
					["]F"] = "@function.outer",
				},
				goto_previous_start = {
					["[="] = "@conditional.outer",
					["[f"] = "@function.outer",
				},
				goto_previous_end = {
					["[+"] = "@conditional.outer",
					["[F"] = "@function.outer",
				},
				goto_next = {
					["]l"] = "@loop.*",
				},
				goto_previous = {
					["]l"] = "@loop.*",
				},
			},
		},
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
