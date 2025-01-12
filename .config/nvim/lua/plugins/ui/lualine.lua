-- Status Line
return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "VeryLazy" },
	opts = {
		options = { theme = "rose-pine" },
		sections = {
			lualine_a = {
				{
					"mode",
				},
				{
					function()
						return "Rec(" .. vim.fn.reg_recording() .. ")"
					end,
					cond = function()
						return vim.fn.reg_recording() ~= ""
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
}
