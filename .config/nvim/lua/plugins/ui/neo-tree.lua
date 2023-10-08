-- File Tree
return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "Neotree",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			{
				"s1n7ax/nvim-window-picker",
				version = "2.*",
				opts = {
					hint = "floating-big-letter",
					filter_rules = {
						include_current_win = false,
						autoselect_one = true,
					},
				},
			},
		},
		keys = {
			{ "<leader>e", "<cmd>Neotree reveal toggle<cr>", desc = "[E]xplore files" },
			{ "<leader>ge", "<cmd>Neotree reveal toggle git_status float<cr>", desc = "[G]it [E]xplore files" },
		},
		opts = {
			close_if_last_window = true,
			window = {
				mappings = {
					["<space>"] = false,
					["<"] = false,
					[">"] = false,
					["s"] = "open_split",
					["v"] = "open_vsplit",
				},
				width = 30,
			},
			filesystem = {
				window = {
					mappings = {
						["<leader>ff"] = "find_files_in_dir",
						["<leader>fl"] = "live_grep_in_dir",
						["Y"] = "copy_file_name",
					},
				},
				commands = {
					find_files_in_dir = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						require("telescope.builtin").find_files({ search_dirs = { path } })
					end,
					live_grep_in_dir = function(state)
						local node = state.tree:get_node()
						local path = node:get_id()
						require("telescope.builtin").live_grep({ search_dirs = { path } })
					end,
					copy_file_name = function(state)
						local node = state.tree:get_node()
						vim.fn.setreg(vim.v.register, node.name)
					end,
				},
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		},
	},
}
