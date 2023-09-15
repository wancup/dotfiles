-- Status Line
return {
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		event = { "VeryLazy" },
		opts = {
			options = { theme = "rose-pine" },
			sections = {
				lualine_a = {
					{
						"mode",
						cond = function()
							return not package.loaded["noice"] or not require("noice").api.status.mode.has()
						end,
					},
					{
						function()
							return require("noice").api.status.mode.get()
						end,
						cond = function()
							return package.loaded["noice"] and require("noice").api.status.mode.has()
						end,
					},
				},
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "filesize" },
				lualine_z = { "progress", "location" },
			},
		},
	},
}
