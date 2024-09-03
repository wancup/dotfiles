local window = require("core.window")
local files = require("mini.files")

vim.keymap.set("n", "J", "j", { buffer = true })
vim.keymap.set("n", "K", "k", { buffer = true })
vim.keymap.set("n", "<leader>q", "q", { buffer = true })

vim.keymap.set("n", "<leader>e", function()
	files.close()
end, { buffer = true, desc = "Close mini.files" })

vim.keymap.set("n", "_", function()
	local cwd = vim.fn.getcwd()
	files.open(cwd)
end, { buffer = true, desc = "Open CWD" })

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
		require("telescope").extensions.live_grep_args.live_grep_args({ search_dirs = { entry.path } })
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

vim.keymap.set("n", "<leader>mY", function()
	local entry = files.get_fs_entry()
	if entry ~= nil then
		local root_path = vim.fs.root(entry.path, ".git")
		local file_path = entry.path
		if root_path ~= nil then
			file_path = string.sub(entry.path, string.len(root_path) + 1)
		end
		vim.fn.setreg(vim.v.register, file_path)
	end
end, { buffer = true, desc = "[M]ini.files [Y]ank file path" })

vim.keymap.set("n", "<leader>m<leader>y", function()
	local entry = files.get_fs_entry()
	if entry ~= nil then
		vim.fn.setreg("+", entry.name)
	end
end, { buffer = true, desc = "[M]ini.files [Y]ank file name to Clipboard" })

vim.keymap.set("n", "<leader>m<leader>Y", function()
	local entry = files.get_fs_entry()
	if entry ~= nil then
		local root_path = vim.fs.root(entry.path, ".git")
		local file_path = entry.path
		if root_path ~= nil then
			file_path = string.sub(entry.path, string.len(root_path) + 1)
		end
		vim.fn.setreg("+", file_path)
	end
end, { buffer = true, desc = "[M]ini.files [Y]ank file path to Clipboard" })

vim.keymap.set("n", "<C-s>", function()
	local entry = files.get_fs_entry()
	if entry ~= nil then
		files.close()
		vim.cmd("split")
		vim.cmd("e " .. entry.path)
	end
end, { buffer = true, desc = "Open file in the split window" })

vim.keymap.set("n", "<C-S-s>", function()
	local entry = files.get_fs_entry()
	if entry ~= nil then
		files.close()
		vim.cmd("vsplit")
		vim.cmd("e " .. entry.path)
	end
end, { buffer = true, desc = "Open file in the vsplit window" })

vim.keymap.set("n", "<C-w>p", function()
	local entry = files.get_fs_entry()
	if entry ~= nil then
		files.close()
		window.select_win(function(win)
			vim.api.nvim_set_current_win(win)
			vim.cmd("e " .. entry.path)
		end)
	end
end, { buffer = true, desc = "mini.files [W]indow [P]ick and open" })
