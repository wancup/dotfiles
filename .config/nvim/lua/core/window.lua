local M = {}

---@class FocusableWin
---@field win integer
---@field float integer
---@field label string

local label_string = "fjdksla;"
local hi_picker_label = "WindowSwitcherLabel"
local hi_picker_sepalator = "WindowSwitcherSepalator"
local hi_picker_file_path = "WindowSwitcherFilePath"

vim.api.nvim_set_hl(0, hi_picker_label, { fg = "#f25070" })
vim.api.nvim_set_hl(0, hi_picker_sepalator, { fg = "#3c3c3c" })
vim.api.nvim_set_hl(0, hi_picker_file_path, { fg = "#696969" })

--- Open float window
--- @param win_id integer
--- @param label_char string
--- @param file_name string
--- @param file_path string
--- @return integer win_id created window id
local function open_picker_win(win_id, label_char, file_name, file_path)
	local win_width = vim.api.nvim_win_get_width(win_id)
	local win_height = vim.api.nvim_win_get_height(win_id)

	local file_extension = vim.fn.fnamemodify(file_name, ":e")
	local icon, icon_hi = require("nvim-web-devicons").get_icon(file_name, file_extension, { default = true })
	local description = icon .. "  " .. file_name
	local description_length = vim.api.nvim_strwidth(description)
	local file_path_length = vim.api.nvim_strwidth(file_path)
	local content_width = math.max(description_length, file_path_length)
	local window_width = content_width + 2

	local label_padding = math.ceil(content_width / 2) - 1
	local label = string.rep(" ", label_padding) .. string.upper(label_char)
	local sepalator = string.rep("─", content_width)
	local buf = vim.api.nvim_create_buf(false, true)

	local buf_contents = { "", label, sepalator, file_path, description, "" }
	local lines = {}
	for _, line in ipairs(buf_contents) do
		table.insert(lines, " " .. line)
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)
	vim.api.nvim_buf_add_highlight(buf, -1, hi_picker_label, 1, 1, content_width)
	vim.api.nvim_buf_add_highlight(buf, -1, hi_picker_sepalator, 2, 1, 1 + vim.fn.strlen(sepalator))
	vim.api.nvim_buf_add_highlight(buf, -1, hi_picker_file_path, 3, 1, 1 + vim.fn.strlen(sepalator))
	vim.api.nvim_buf_add_highlight(buf, -1, icon_hi, 4, 2, 2 + vim.fn.strlen(icon))

	local x = math.floor((win_width / 2) - (content_width / 2))
	local y = math.floor(win_height / 2) - 2
	local win = vim.api.nvim_open_win(buf, false, {
		win = win_id,
		relative = "win",
		focusable = false,
		zindex = 1000,
		col = x,
		row = y,
		style = "minimal",
		width = window_width,
		height = table.maxn(buf_contents),
		border = "rounded",
	})

	return win
end

---@param focusable_wins FocusableWin[]
---@param callback fun(win_id: integer)
local function select_win(focusable_wins, callback)
	local success, input_code = pcall(vim.fn.getchar)
	if success and type(input_code) == "number" then
		local input_char = vim.fn.nr2char(input_code)
		for _, candidate in ipairs(focusable_wins) do
			if candidate.label == input_char then
				callback(candidate.win)
			end
		end
	end
end

---@return FocusableWin[]
local function get_focusable_wins()
	local wins = vim.api.nvim_tabpage_list_wins(0)
	local focusable_wins = {}

	for _, win in ipairs(wins) do
		-- TODO: use goto continue(StyLua #407)
		local win_config = vim.api.nvim_win_get_config(win)
		local is_focusable = vim.api.nvim_win_is_valid(win) and win_config.focusable

		if is_focusable then
			local buf = vim.api.nvim_win_get_buf(win)
			local file_full_path = vim.api.nvim_buf_get_name(buf)
			local file_path = vim.fn.fnamemodify(file_full_path, ":.:h")
			local shorten_file_path = vim.fn.pathshorten(file_path, 3) .. "/"
			local file_name = vim.fn.fnamemodify(file_full_path, ":t")
			local label_index = table.maxn(focusable_wins) + 1

			-- TODO: check out of range
			local label = string.sub(label_string, label_index, label_index)
			local opened_win = open_picker_win(win, label, file_name, shorten_file_path)

			local candidate = {
				win = win,
				float = opened_win,
				label = label,
			}
			table.insert(focusable_wins, candidate)
		end
	end
	return focusable_wins
end

---@param callback fun(win_id: integer)
M.select_win = function(callback)
	local current_win = vim.api.nvim_get_current_win()
	local focusable_wins = get_focusable_wins()
	local focusable_win_size = table.maxn(focusable_wins)

	local close_pickup_wins = function()
		for _, win in ipairs(focusable_wins) do
			vim.api.nvim_win_close(win.float, true)
		end
	end

	if focusable_win_size == 2 then
		for _, candidate in ipairs(focusable_wins) do
			if candidate.win ~= current_win then
				close_pickup_wins()
				callback(candidate.win)
			end
		end
	elseif focusable_win_size > 2 then
		vim.api.nvim_command("redraw")
		select_win(focusable_wins, function(win_id)
			close_pickup_wins()
			callback(win_id)
		end)
	end
end

M.pick_win = function()
	M.select_win(vim.api.nvim_set_current_win)
end

M.previous_win = function()
	local current_win = vim.api.nvim_get_current_win()
	vim.cmd("wincmd p")
	local selected_win = vim.api.nvim_get_current_win()
	if selected_win ~= current_win then
		return
	end

	M.pick_win()
end

M.remove_win_buf = function()
	local _remove_buf = function(win_id)
		local buf = vim.api.nvim_win_get_buf(win_id)
		vim.api.nvim_buf_call(buf, function()
			vim.cmd("bdelete")
		end)
	end
	M.select_win(_remove_buf)
end

M.hide_win = function()
	M.select_win(vim.api.nvim_win_hide)
end

local aspect_ratio = 2.5
M.toggle_orientation = function()
	local buf = vim.api.nvim_get_current_buf()
	local win_width = vim.api.nvim_win_get_width(0)
	local win_height = vim.api.nvim_win_get_height(0)

	vim.api.nvim_win_hide(0)

	if win_width > (win_height * aspect_ratio) then
		vim.cmd("vsplit")
		local opened_win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_buf(opened_win, buf)
	else
		vim.cmd("split")
		local opened_win = vim.api.nvim_get_current_win()
		vim.api.nvim_win_set_buf(opened_win, buf)
	end
end

return M
