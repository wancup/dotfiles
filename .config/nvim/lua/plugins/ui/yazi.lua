return {
	{
		"mikavilpas/yazi.nvim",
		keys = {
			{
				"<leader>e",
				"<cmd>Yazi<cr>",
				desc = "[E]xplore files",
			},
			{
				"<leader>E",
				"<cmd>Yazi toggle<cr>",
				desc = "Yazi toggle",
			},
		},
		opts = {
			keymaps = {
				show_help = "<F1>",
				open_file_in_vertical_split = "<C-S-s>",
				open_file_in_horizontal_split = "<C-s>",
				open_file_in_tab = false,
				grep_in_directory = "<C-space>",
				replace_in_directory = "<C-g>",
				cycle_open_buffers = "_",
				copy_relative_path_to_selected_files = "<C-y>",
				send_to_quickfix_list = "<C-q>",
				change_working_directory = "=",
			},
			integrations = {
				grep_in_directory = function(directory)
					require("telescope").extensions.live_grep_args.live_grep_args({ search_dirs = { directory } })
				end,
			},
		},
	},
}
