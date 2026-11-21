return {
	cmd = { "efm-langserver" },
	root_dir = function(bufnr, on_dir)
		local path = vim.api.nvim_buf_get_name(bufnr)
		if vim.bo[bufnr].buftype == "" and path ~= "" then
			on_dir(vim.fs.root(path, ".git") or vim.fs.dirname(path))
		end
	end,
}
