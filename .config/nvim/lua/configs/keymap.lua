local buffer = require("core.buffer")
local diagnostic = require("core.diagnostic")
local git = require("core.git")
local window = require("core.window")
local register = require("core.register")
local float_lsp = require("core.float-lsp")
local map = vim.keymap.set

-- Remove unused default keymap
vim.keymap.del({ "n" }, "grn")
vim.keymap.del({ "n" }, "grr")
vim.keymap.del({ "n" }, "gri")
vim.keymap.del({ "n", "x" }, "gra")

-- Normal and Visual
map({ "n", "x" }, "<leader>y", '"+y', { desc = "[Y]ank to Clipboard" })
map({ "n", "x" }, "M", "`m")
map({ "n", "x" }, "j", "gj", { noremap = true })
map({ "n", "x" }, "gj", "j", { noremap = true })
map({ "n", "x" }, "k", "gk", { noremap = true })
map({ "n", "x" }, "gk", "k", { noremap = true })

map({ "n", "x" }, "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })

map({ "n", "x" }, "g<esc>", float_lsp.close_all_window, { desc = "Close LSP Info Windows" })
map({ "n", "x" }, "gr", float_lsp.show_references, { desc = "[G]oto [R]eferences" })
map({ "n", "x" }, "gt", float_lsp.show_type_definition, { desc = "[G]oto [T]ype Definitions" })
map({ "n", "x" }, "gd", float_lsp.show_definition, { desc = "[G]oto [D]ifinition" })
map({ "n", "x" }, "gI", float_lsp.show_implementation, { desc = "[G]oto [I]mplementation" })
map({ "n", "x" }, "gb", vim.lsp.buf.document_symbol, { desc = "[G]oto Sym[b]ol" })
map({ "n", "x" }, "gB", vim.lsp.buf.workspace_symbol, { desc = "[G]oto Sym[b]ol(Workspace)" })

map({ "n", "x" }, "<leader>d", function()
	vim.diagnostic.open_float({ source = true })
end, { desc = "[D]iagnostics" })

map({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, { desc = "Code [A]ction" })
map({ "n", "x" }, "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[N]ame" })

-- Normal
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>")
map("n", "<C-h>", "<C-w>h", { desc = "Goto left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Goto bellow window" })
map("n", "<C-k>", "<C-w>k", { desc = "Goto above window" })
map("n", "<C-l>", "<C-w>l", { desc = "Goto right window" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear highlight" })
map("n", "<C-p>", window.previous_win, { desc = "[P]revious Window" })
map("n", "<C-S-p>", window.pick_win, { desc = "[P]ick Window" })
map("n", "<C-w>r", window.toggle_orientation, { desc = "[R]otate Window" })
map("n", "<C-w>c", window.remove_win_buf, { desc = "[C]lose Window" })
map("n", "<C-w>C", window.hide_win, { desc = "Hide Window" })
map("n", "<C-w><C-w>", window.previous_win, { desc = "Select Previous Window" })
map("n", "<cr>", "a<Cr><Esc>")
map("n", "<S-cr>", "i<Cr><Esc>")
map("n", "<leader>w", "<cmd>wa<cr>", { desc = "Write All" })
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>bd", buffer.delete_buffer, { desc = "[B]uffer [D]elete" })
map("n", "<leader>p", '"+p', { desc = "[P]aste from Clipboard" })
map("n", "<leader>P", '"+P', { desc = "[P]aste from Clipboard" })
map("n", "<leader>ll", "<cmd>copen<cr>", { desc = "[L]ist Quickfix" })
map("n", "<leader>lc", git.conflict_list, { desc = "[L]ist Git [C]onflict" })
map("n", "<leader>ld", diagnostic.current_buf_list, { desc = "[L]ist [D]iagnostics" })
map("n", "<leader>lD", diagnostic.workspace_list, { desc = "[L]ist [D]iagnostics(Workspace)" })
map("n", "<C-e>", register.edit_register, { desc = "Edit Register" })

-- Insert
map("i", "<C-h>", "<BS>")
map("i", "<C-d>", "<Delete>")
map("i", "<C-k>", "<C-o>d$")
map("i", "<C-a>", "<Home>")
map("i", "<C-e>", "<End>")
map("i", "<C-n>", "<Down>")
map("i", "<C-p>", "<Up>")
map("i", "<C-f>", "<Right>")
map("i", "<C-b>", "<Left>")
map("i", "<C-l>", "<Esc>la")
map("i", "<C-r><C-r>", "<C-r>0")

-- Visual
map("x", "y", "ygv<Esc>")
