local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("RemoveAutoComment"),
	callback = function()
		-- avoid to automatic comment out
		vim.opt.formatoptions:remove("r")
		vim.opt.formatoptions:remove("o")
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = augroup("SetupTsc"),
	pattern = { "*.ts", "*.tsx" },
	callback = function()
		vim.cmd("compiler tsc")
		vim.opt.makeprg = "npx tsc --noEmit --skipLibCheck"
	end,
})
