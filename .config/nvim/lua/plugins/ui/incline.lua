return {
	"b0o/incline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "WinNew" },
	opts = {
		debounce_threshold = {
			falling = 500,
			rising = 100,
		},
		window = {
			zindex = 5,
		},
		render = function(props)
			local buf_name = vim.api.nvim_buf_get_name(props.buf)
			local file_name = vim.fn.fnamemodify(buf_name, ":t")
			local file_extension = vim.fn.fnamemodify(file_name, ":e")
			local icon, icon_color =
				require("nvim-web-devicons").get_icon_color(file_name, file_extension, { default = true })
			local modified = vim.bo[props.buf].modified
			return {
				{
					" ",
					icon,
					" ",
					guifg = icon_color,
				},
				" ",
				{ file_name, gui = modified and "bold,italic" or nil },
				" ",
			}
		end,
	},
}
