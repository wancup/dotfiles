local M = {}

M.delete_buffer = function()
	local current_buf = vim.api.nvim_get_current_buf()
	local alt_buf = vim.fn.bufnr("#")
	if vim.api.nvim_buf_is_valid(alt_buf) then
		vim.api.nvim_set_current_buf(alt_buf)
		vim.api.nvim_buf_delete(current_buf, {})
	else
		vim.notify("Alternate buffer is invalid!")
	end
end

return M
