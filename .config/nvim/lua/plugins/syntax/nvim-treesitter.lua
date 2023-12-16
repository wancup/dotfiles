return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"windwp/nvim-ts-autotag",
		},
		keys = {
			{ "<C-space>", desc = "Increment node selection" },
			{ "<C-h>", desc = "Decrement node selection", mode = "x" },
		},
		opts = {
			highlight = { enable = true },
			indent = { enable = true },
			autotag = { enable = true },
			ensure_installed = {
				"bash",
				"html",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<C-h>",
				},
			},
			context_commentstring = {
				enable = true,
				enable_autocmd = false,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["ia"] = "@assignment.inner",
						["aa"] = "@assignment.outer",
						["ib"] = "@block.inner",
						["ab"] = "@block.outer",
						["ic"] = "@class.inner",
						["ac"] = "@class.outer",
						["iC"] = "@call.inner",
						["aC"] = "@call.outer",
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
						["]b"] = "@block.outer",
						["]c"] = "@class.outer",
						["]="] = "@conditional.outer",
						["]f"] = "@function.outer",
					},
					goto_next_end = {
						["]B"] = "@block.outer",
						["]C"] = "@class.outer",
						["]+"] = "@conditional.outer",
						["]F"] = "@function.outer",
					},
					goto_previous_start = {
						["[b"] = "@block.outer",
						["[c"] = "@class.outer",
						["[="] = "@conditional.outer",
						["[f"] = "@function.outer",
					},
					goto_previous_end = {
						["[B"] = "@block.outer",
						["[C"] = "@class.outer",
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
	},
}
