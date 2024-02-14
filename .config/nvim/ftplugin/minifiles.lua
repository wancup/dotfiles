local files = require("mini.files")

vim.keymap.set("n", "<leader>e", function()
	files.close()
end, { buffer = true, desc = "Close mini.files" })

vim.keymap.set("n", "_", function()
	local cwd = vim.fn.getcwd()
	files.open(cwd)
end, { buffer = true, desc = "Open CDW" })

vim.keymap.set("n", "<cr>", function()
	files.go_in({ close_on_file = true })
end, { buffer = true })

vim.keymap.set("n", "<S-cr>", function()
	files.go_out()
end, { buffer = true })

vim.keymap.set("n", "<leader><leader>", function()
	local entry = files.get_fs_entry()
	if entry ~= nil then
		files.close()
		require("telescope.builtin").live_grep({ search_dirs = { entry.path } })
	end
end, { buffer = true, desc = "Live-grep in dir" })

vim.keymap.set("n", "<leader>ff", function()
	local entry = files.get_fs_entry()
	if entry ~= nil then
		files.close()
		require("telescope.builtin").find_files({ search_dirs = { entry.path } })
	end
end, { buffer = true, desc = "[F]ind [F]iles in dir" })

vim.keymap.set("n", "<leader>my", function()
	local entry = files.get_fs_entry()
	if entry ~= nil then
		vim.fn.setreg(vim.v.register, entry.name)
	end
end, { buffer = true, desc = "[M]ini.files [Y]ank file name" })
