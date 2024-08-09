return {
	{
		"stevearc/aerial.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		cmd = { "AerialToggle", "AerialOpen", "AerialOpenAll", "AerialNavToggle", "AerialNavOpen" },
		keys = {
			{ "<leader>o", "<cmd>AerialToggle<cr>", desc = "[O]utline" },
			{ "<leader>O", "<cmd>AerialNavToggle<cr>", desc = "[O]utline(Nav)" },
		},
		opts = {
			layout = {
				max_width = { 40, 0.5 },
				default_direction = "float",
			},
			keymaps = {
				["<C-S-s>"] = "actions.jump_vsplit",
				["<C-s>"] = "actions.jump_split",
				["p"] = "actions.scroll",
				["<S-J>"] = "actions.down_and_scroll",
				["<S-k>"] = "actions.up_and_scroll",
			},
			highlight_on_jump = 1000,
			close_on_select = true,
			show_guides = true,
			float = {
				relative = "win",
				override = function(conf, source_winid)
					conf.anchor = "NE"
					conf.row = 0
					conf.col = vim.api.nvim_win_get_width(source_winid)
					return conf
				end,
			},
			nav = {
				keymaps = {
					["<C-S-s>"] = "actions.jump_vsplit",
					["<C-s>"] = "actions.jump_split",
					["H"] = "actions.left",
					["L"] = "actions.right",
					["q"] = "actions.close",
				},
			},
		},
	},
}
