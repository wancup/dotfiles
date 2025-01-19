require("configs.option")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		{ import = "plugins.ai" },
		{ import = "plugins.coding" },
		{ import = "plugins.color" },
		{ import = "plugins.command" },
		{ import = "plugins.git" },
		{ import = "plugins.input" },
		{ import = "plugins.lsp" },
		{ import = "plugins.syntax" },
		{ import = "plugins.ui" },
	},
})
require("configs.keymap")
require("configs.goto")
require("configs.autocmd")
