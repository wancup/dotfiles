vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Operation
opt.confirm = true
opt.mouse = "a"
opt.spell = true
opt.spelllang = "en_us"
opt.timeoutlen = 5000
opt.shell = "fish"

-- UI
opt.cursorline = true
opt.number = true
opt.termguicolors = true
opt.breakindent = true
opt.list = true
opt.listchars = { tab = "» " }
opt.ambiwidth = "single"
opt.laststatus = 1

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
