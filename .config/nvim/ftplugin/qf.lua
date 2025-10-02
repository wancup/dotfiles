vim.keymap.set("n", "q", function()
	vim.cmd("wincmd p")
	vim.cmd("cclose")
	require("focus").focus_autoresize()
end, { buffer = true })

-- Move qf window to bottom
vim.cmd("wincmd J")
