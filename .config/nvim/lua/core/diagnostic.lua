local M = {}

local severity_map = {
	[1] = "E",
	[2] = "W",
	[3] = "I",
	[4] = "N",
}

local add_qflist = function(diagnostic)
	local entry = {
		bufnr = diagnostic.bufnr,
		filename = vim.fn.bufname(diagnostic.bufnr),
		lnum = diagnostic.lnum + 1,
		end_lnum = diagnostic.end_lnum + 1,
		col = diagnostic.col + 1,
		end_col = diagnostic.end_col + 1,
		text = diagnostic.message,
		type = severity_map[diagnostic.severity],
	}
	vim.fn.setqflist({ entry }, "a")
end

function M.current_buf_list()
	local current_bufnr = vim.api.nvim_get_current_buf()

	local all = vim.diagnostic.get(current_bufnr)
	vim.fn.setqflist({}, " ", { title = "Diagnostics" })
	for _, item in ipairs(all) do
		add_qflist(item)
	end

	vim.api.nvim_command("copen")
end

function M.workspace_list()
	local all = vim.diagnostic.get()
	vim.fn.setqflist({}, " ", { title = "Diagnostics(Workspace)" })
	for _, item in ipairs(all) do
		add_qflist(item)
	end

	vim.api.nvim_command("copen")
end

return M
