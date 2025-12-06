local MAX_FILE_PATH_LENGTH = 15

local function get_diagnostic_label(bufnr)
	local icons = { error = "", warn = "", info = "", hint = "" }
	local label = {}

	for severity, diagnostic_icon in pairs(icons) do
		local n = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity[string.upper(severity)] })
		if n > 0 then
			table.insert(label, { diagnostic_icon .. " ", group = "DiagnosticSign" .. severity })
		end
	end
	if #label > 0 then
		table.insert(label, { "┊ " })
	end
	return label
end

return {
	"b0o/incline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = { "WinNew" },
	opts = {
		debounce_threshold = {
			falling = 100,
			rising = 50,
		},
		hide = {
			cursorline = true,
		},
		window = {
			zindex = 1,
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
				{ get_diagnostic_label(props.buf) },
				{
					icon,
					" ",
					guifg = icon_color,
				},
				" ",
				{ shorten_file_path },
				"/",
				{ file_name, gui = modified and "bold,italic" or "bold" },
				{
					vim.bo[props.buf].modified and "・" or "",
					group = "WarningMsg",
				},
				" ",
			}
		end,
	},
}
