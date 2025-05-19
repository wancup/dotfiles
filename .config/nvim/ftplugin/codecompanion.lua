vim.keymap.set("n", "q", function()
	vim.cmd("CodeCompanionChat Toggle")
end, { buffer = true })
