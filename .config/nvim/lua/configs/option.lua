local font = require("core/font")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Operation
opt.confirm = true
opt.mouse = "a"
opt.undofile = true
opt.timeoutlen = 5000
opt.shell = "fish"

-- UI
opt.cursorline = true
opt.number = true
opt.termguicolors = true
opt.scrolloff = 10
opt.breakindent = true
opt.splitbelow = true
opt.splitright = true
opt.pumheight = 10
opt.laststatus = 3
opt.list = true
opt.listchars = { tab = "» ", lead = "˒" }
opt.ambiwidth = "single"
font.apply_cellwidths()

-- Search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Indent
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 0
opt.softtabstop = -1
opt.autoindent = true
opt.smartindent = true

-- LSP
vim.diagnostic.config({
	virtual_text = { source = true },
	underline = true,
	severity_sort = true,
})
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("dprint")
vim.lsp.inlay_hint.enable(true)

-- Custom Filetype
vim.filetype.add({
	filename = {
		[".env"] = "conf",
	},
	pattern = {
		[".*/%.github/workflows/.*%.y(a?)ml"] = "yaml.gha",
	},
})
