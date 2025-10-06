local M = {}

local MAX_LINE_LENGTH = 1000
local HI_FT_FIRST = "FtHighlightFirst"
local HI_FT_SECOND = "FtHighlightSecond"
local FT_NS_ID = vim.api.nvim_create_namespace("ft_highlight")

local is_highlighted = false

vim.api.nvim_set_hl(0, HI_FT_FIRST, { fg = "#f6c177" })
vim.api.nvim_set_hl(0, HI_FT_SECOND, { fg = "#56949f" })

local function highlight_char(buf, col, prev_count)
	local cursor_row_num = vim.api.nvim_win_get_cursor(0)[1] - 1
	local higroup = prev_count == 0 and HI_FT_FIRST or HI_FT_SECOND
	vim.hl.range(buf, FT_NS_ID, higroup, { cursor_row_num, col }, { cursor_row_num, col })
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

local function should_ignore()
	local mode = vim.fn.mode()
	return mode:match("^[ict]") ~= nil
end

local function clear_highlight()
	vim.api.nvim_buf_clear_namespace(0, FT_NS_ID, 0, -1)
	is_highlighted = false
end

---@param command 'f'| 't' | 'F' | 'T'
local function apply_highlight(command)
	local cursor_line = vim.api.nvim_get_current_line()
	if #cursor_line < 2 or #cursor_line > MAX_LINE_LENGTH then
		return
	end

	local buf = vim.api.nvim_get_current_buf()
	local cursor_row_num = vim.api.nvim_win_get_cursor(0)[1] - 1
	vim.hl.range(buf, FT_NS_ID, "Comment", { cursor_row_num, 1 }, { cursor_row_num, #cursor_line })

	if command == "f" or command == "t" then
		highlight_forward(buf, cursor_line)
	else
		highlight_backward(buf, cursor_line)
	end
	is_highlighted = true

	vim.api.nvim_command("redraw")
end

M.setup = function()
	vim.on_key(function(key)
		if is_highlighted then
			clear_highlight()
			return
		end

		if should_ignore() then
			return
		end

		local command = vim.fn.keytrans(key)

		if command:match("^[ftFT]$") then
			apply_highlight(command)
			return
		end

		if command:match("^<Esc>$") then
			clear_highlight()
			return
		end
	end)
end

return M
