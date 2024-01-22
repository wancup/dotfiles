local M = {}

local conflict_pattern = "^<<<<<<<"

M.conflict_list = function()
	local bufnr = vim.api.nvim_get_current_buf()
	local lines = vim.fn.getline(1, "$")

	vim.fn.setqflist({}, " ", { title = "Git Conflict" })
	for i, line in ipairs(lines) do
		if line:match(conflict_pattern) then
			local entry = {
				bufnr = bufnr,
				filename = vim.fn.bufname(),
				lnum = i,
				col = 1,
				text = line,
				type = "E",
			}
			vim.fn.setqflist({ entry }, "a")
		end
	end

	vim.api.nvim_command("copen")
end

M.prev_conflict = function()
	local current_line = vim.fn.line(".") + 1
	local lines = vim.fn.getline(1, current_line)
	for i, line in ipairs(lines) do
		if line:match(conflict_pattern) then
			vim.api.nvim_win_set_cursor(0, { i, 0 })
			return
		end
	end
end

M.next_conflict = function()
	local start_line = vim.fn.line(".") + 1
	local lines = vim.fn.getline(start_line, "$")
	for i, line in ipairs(lines) do
		if line:match(conflict_pattern) then
			vim.api.nvim_win_set_cursor(0, { start_line + i - 1, 0 })
			return
		end
	end
end

return M
