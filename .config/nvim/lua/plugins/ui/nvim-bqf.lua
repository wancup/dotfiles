return {
	{
		"kevinhwang91/nvim-bqf",
		ft = { "qf" },
		opts = {
			magic_window = false,
			auto_resize_height = true,
			preview = {
				win_height = 30,
			},
			func_map = {
				open = "o",
				openc = "<cr>",
				drop = "O",
				split = "s",
				vsplit = "S",
				lastleave = "gl",
				stoggleup = "u",
				stoggledown = "<space>",
				stogglevm = "<space>",
				stogglebuf = "<C-space>",
				sclear = "c",
				pscrollup = "<PageUp>",
				pscrolldown = "<PageDown>",
				pscrollorig = "r",
				ptogglemode = "m",
				filter = "fn",
				filterr = "fd",
			},
		},
	},
}
