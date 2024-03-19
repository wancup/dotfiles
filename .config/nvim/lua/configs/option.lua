vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Operation
opt.confirm = true
opt.mouse = "a"
opt.undofile = true
opt.spell = true
opt.spelllang = "en_us"
opt.timeoutlen = 300

-- UI
opt.cursorline = true
opt.number = true
opt.termguicolors = true
opt.scrolloff = 10
opt.breakindent = true
opt.splitbelow = true
opt.splitright = true
opt.pumheight = 10
opt.relativenumber = true
opt.laststatus = 3
opt.list = true
opt.listchars = { tab = "» " }

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

-- Avoid to invalid emooji display
vim.fn.setcellwidths({ { 0x2600, 0x27FF, 2 }, { 0x1F000, 0x1FFFF, 2 }, { 0x2B06, 0x2B07, 2 } })

-- LSP
vim.diagnostic.config({ virtual_text = { source = true } })

-- Custom Filetype
vim.filetype.add({
	filename = {
		[".env"] = "conf",
	},
})
