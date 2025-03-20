local MAX_FILE_PATH_LENGTH = 15

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
			local file_path = vim.fn.fnamemodify(buf_name, ":p:.:h")
			local file_name = vim.fn.fnamemodify(buf_name, ":t")
			local file_extension = vim.fn.fnamemodify(file_name, ":e")
			local icon, icon_color =
				require("nvim-web-devicons").get_icon_color(file_name, file_extension, { default = true })
			local modified = vim.bo[props.buf].modified
			local shorten_file_path = string.len(file_path) > MAX_FILE_PATH_LENGTH
					and ".." .. string.sub(file_path, -MAX_FILE_PATH_LENGTH)
				or file_path
			return {
				{
					" ",
					icon,
					" ",
					guifg = icon_color,
				},
				" ",
				{ shorten_file_path },
				"/",
				{ file_name, gui = modified and "bold,italic" or "bold" },
				" ",
			}
		end,
	},
}
