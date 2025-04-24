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

-- Avoid to invalid ambiwidth chars display
vim.fn.setcellwidths({
	{ 0x1F000, 0x1FFFF, 2 }, -- 🀀 ~ 🫸
	{ 0x2190, 0x2193, 2 }, -- ← ~ ↓
	{ 0x2025, 0x2026, 2 }, -- ‥ ~ …
	{ 0x2460, 0x2473, 2 }, -- ① ~ ⑳
	{ 0x2600, 0x27FF, 2 }, -- ☀ ~ ⛿
	{ 0x2B05, 0x2B07, 2 }, -- ⬅ ~ ⬇
	{ 0x25BC, 0x25BD, 2 }, -- ▼ ~ ▽
})

-- LSP
vim.diagnostic.config({
	virtual_text = { source = true },
	underline = true,
	severity_sort = true,
})
vim.lsp.enable("dprint")

-- Custom Filetype
vim.filetype.add({
	filename = {
		[".env"] = "conf",
	},
	pattern = {
		[".*/%.github/workflows/.*%.y(a?)ml"] = "yaml.gha",
	},
})
