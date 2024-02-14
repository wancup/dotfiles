vim.keymap.set("n", "_", function()
	local cwd = vim.fn.getcwd()
	require("mini.files").open(cwd)
end, { buffer = true })

vim.keymap.set("n", "<cr>", function()
	require("mini.files").go_in({ close_on_file = true })
end, { buffer = true })

vim.keymap.set("n", "<S-cr>", function()
	require("mini.files").go_out()
end, { buffer = true })
