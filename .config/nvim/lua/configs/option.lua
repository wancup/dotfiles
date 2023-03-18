vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

-- Operation
opt.confirm = true
opt.mouse = "a"
opt.undofile = true
opt.clipboard = "unnamedplus"
opt.spelllang = { "en" }

-- UI
opt.cursorline = true
opt.virtualedit = "onemore"
opt.number = true
opt.termguicolors = true
opt.scrolloff = 4
opt.breakindent = true
opt.splitbelow = true
opt.splitright = true
opt.pumheight = 10

-- Search
opt.hlsearch = true
opt.ignorecase = true
opt.smartcase = true

-- Indent
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.autoindent = true
opt.smartindent = true
