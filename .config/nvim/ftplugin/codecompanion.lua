vim.keymap.set("n", "<C-q>", function()
	vim.cmd("CodeCompanionChat Toggle")
end, { buffer = true })
