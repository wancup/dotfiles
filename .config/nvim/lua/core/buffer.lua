local M = {}

local function is_buf_already_showed(bufnr)
	local windows = vim.api.nvim_list_wins()
	for _, win in ipairs(windows) do
		if vim.api.nvim_win_get_buf(win) == bufnr then
			return true
		end
	end
	return false
end

function M.delete_buffer()
	local current_buf = vim.api.nvim_get_current_buf()
	local alt_buf = vim.fn.bufnr("#")
	if vim.api.nvim_buf_is_valid(alt_buf) then
		if is_buf_already_showed(alt_buf) then
			vim.cmd("bdelete")
		else
			vim.api.nvim_set_current_buf(alt_buf)
			vim.api.nvim_buf_delete(current_buf, {})
		end
	else
		vim.cmd("bdelete")
	end
end

function M.delete_other_buffers()
	local current_buf = vim.api.nvim_get_current_buf()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(buf) and buf ~= current_buf then
			vim.api.nvim_buf_delete(buf, {})
		end
	end
end

return M
