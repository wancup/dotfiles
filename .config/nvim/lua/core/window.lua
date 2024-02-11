local M = {}

---@class FocusableWin
---@field win integer
---@field float integer
---@field label string

local label_string = "fjdksla;"

--- Open float window
--- @param win_id integer
--- @param label_char string
--- @param file_name string
--- @return integer win_id created window id
local function open_picker_win(win_id, label_char, file_name)
	local win_width = vim.api.nvim_win_get_width(win_id)
	local win_height = vim.api.nvim_win_get_height(win_id)

	local file_name_length = vim.api.nvim_strwidth(file_name)
	local label_padding = math.ceil(file_name_length / 2) - 1
	local label = string.rep(" ", label_padding) .. string.upper(label_char)
	local sepalator = string.rep("─", file_name_length)
	local buf = vim.api.nvim_create_buf(false, true)

	local buf_contents = { "", label, sepalator, file_name, "" }
	local lines = {}
	for _, line in ipairs(buf_contents) do
		table.insert(lines, " " .. line)
	end
	vim.api.nvim_buf_set_lines(buf, 0, -1, true, lines)

	local x = math.floor((win_width / 2) - (file_name_length / 2))
	local y = math.floor(win_height / 2) - 2
	local win = vim.api.nvim_open_win(buf, false, {
		win = win_id,
		relative = "win",
		focusable = false,
		zindex = 1000,
		col = x,
		row = y,
		style = "minimal",
		width = file_name_length + 2,
		height = 5,
	})

	return win
end

---@param focusable_wins FocusableWin[]
local function select_win(focusable_wins)
	local success, input_code = pcall(vim.fn.getchar)
	print(input_code)
	if success and type(input_code) == "number" then
		local input_char = vim.fn.nr2char(input_code)
		for _, candidate in ipairs(focusable_wins) do
			if candidate.label == input_char then
				vim.api.nvim_set_current_win(candidate.win)
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
			local file_path = vim.api.nvim_buf_get_name(buf)
			local file_name = vim.fn.fnamemodify(file_path, ":t")
			local label_index = table.maxn(focusable_wins) + 1

			-- TODO: check out of range
			local label = string.sub(label_string, label_index, label_index)
			local opened_win = open_picker_win(win, label, file_name)

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

M.pick_win = function()
	local current_win = vim.api.nvim_get_current_win()
	local focusable_wins = get_focusable_wins()
	local focusable_win_size = table.maxn(focusable_wins)
	if focusable_win_size == 2 then
		for _, candidate in ipairs(focusable_wins) do
			if candidate.win ~= current_win then
				vim.api.nvim_set_current_win(candidate.win)
			end
		end
	elseif focusable_win_size > 2 then
		vim.api.nvim_command("redraw")
		select_win(focusable_wins)
	end

	-- close all floating wins
	for _, win in ipairs(focusable_wins) do
		vim.api.nvim_win_close(win.float, true)
	end
end

M.switch_win = function()
	local current_win = vim.api.nvim_get_current_win()
	vim.cmd("wincmd p")
	local selected_win = vim.api.nvim_get_current_win()
	if selected_win ~= current_win then
		return
	end

	M.pick_win()
end

return M
