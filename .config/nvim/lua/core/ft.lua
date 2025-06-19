local M = {}

local MAX_LINE_LENGTH = 1000

local hi_ft_first = "FtHighlightFirst"
local hi_ft_second = "FtHighlightSecond"
local ft_ns_id = vim.api.nvim_create_namespace("ft_highlight")

vim.api.nvim_set_hl(0, hi_ft_first, { fg = "#f6c177" })
vim.api.nvim_set_hl(0, hi_ft_second, { fg = "#56949f" })

local function highlight_char(buf, col, prev_count)
	local cursor_row_num = vim.api.nvim_win_get_cursor(0)[1] - 1
	local higroup = prev_count == 0 and hi_ft_first or hi_ft_second
	vim.hl.range(buf, ft_ns_id, higroup, { cursor_row_num, col }, { cursor_row_num, col })
end

local function highlight_forward(buf, cursor_line)
	local cursor_col_num = vim.api.nvim_win_get_cursor(0)[2]
	local char_dict = {}
	for i = 2, #cursor_line do
		if i <= cursor_col_num + 1 then
			goto continue
		end

		local char = cursor_line:sub(i, i)
		local prev_count = char_dict[char] or 0
		if prev_count <= 1 then
			highlight_char(buf, i - 1, prev_count)
		end

		char_dict[char] = prev_count + 1
		::continue::
	end
end

local function highlight_backward(buf, cursor_line)
	local cursor_col_num = vim.api.nvim_win_get_cursor(0)[2]
	local char_dict = {}
	for i = #cursor_line, 1, -1 do
		if i > cursor_col_num then
			goto continue
		end

		local char = cursor_line:sub(i, i)
		local prev_count = char_dict[char] or 0
		if prev_count <= 1 then
			highlight_char(buf, i - 1, prev_count)
		end

		char_dict[char] = prev_count + 1
		::continue::
	end
end

---@param command 'f'| 't' | 'F' | 'T'
---@param mode 'o' | 'any'
M.highlight_ft = function(command, mode)
	local cursor_line = vim.api.nvim_get_current_line()
	if #cursor_line < 2 or #cursor_line > MAX_LINE_LENGTH then
		vim.notify("[FT] No length to motion!", vim.log.levels.DEBUG)
		return
	end

	local buf = vim.api.nvim_get_current_buf()
	local cursor_row_num = vim.api.nvim_win_get_cursor(0)[1] - 1
	vim.hl.range(buf, ft_ns_id, "Comment", { cursor_row_num, 1 }, { cursor_row_num, #cursor_line })

	if command == "f" or command == "t" then
		highlight_forward(buf, cursor_line)
	else
		highlight_backward(buf, cursor_line)
	end

	vim.notify("[FT] Wait for input!", vim.log.levels.DEBUG)
	vim.api.nvim_command("redraw")
	local success, input_code = pcall(vim.fn.getchar)
	if success and type(input_code) == "number" then
		local input_char = vim.fn.nr2char(input_code)
		if mode == "o" then
			local op = vim.api.nvim_eval("v:operator")
			vim.notify(op)
			vim.api.nvim_feedkeys(op .. command .. input_char, "n", false)
		else
			vim.api.nvim_feedkeys(command .. input_char, "n", false)
		end
	end
	vim.api.nvim_buf_clear_namespace(0, ft_ns_id, 0, -1)
end

return M
