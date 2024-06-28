return {
	{
		"kevinhwang91/nvim-bqf",
		ft = { "qf" },
		opts = {
			magic_window = false,
			auto_resize_height = true,
			preview = {
				win_height = 25,
			},
			func_map = {
				open = "o",
				openc = "<cr>",
				drop = "O",
				split = "<C-s>",
				vsplit = "<C-S-s>",
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
