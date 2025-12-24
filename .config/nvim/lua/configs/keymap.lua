local buffer = require("core.buffer")
local diagnostic = require("core.diagnostic")
local git = require("core.git")
local window = require("core.window")
local register = require("core.register")
local float_lsp = require("core.float-lsp")
local input = require("core.input")
local map = vim.keymap.set

-- Remove unused default keymap
vim.keymap.del({ "n" }, "grn")
vim.keymap.del({ "n" }, "grr")
vim.keymap.del({ "n" }, "gri")
vim.keymap.del({ "n", "x" }, "gra")

-- Normal and Visual
map({ "n", "x" }, "<leader>y", '"+y', { desc = "Yank to Clipboard" })
map({ "n", "x" }, "M", "`m")
map({ "n", "x" }, "j", "gj", { noremap = true })
map({ "n", "x" }, "gj", "j", { noremap = true })
map({ "n", "x" }, "k", "gk", { noremap = true })
map({ "n", "x" }, "gk", "k", { noremap = true })

map({ "n", "x" }, "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })

map({ "n", "x" }, "g<esc>", float_lsp.close_all_window, { desc = "Close LSP Info Windows" })
map({ "n", "x" }, "gr", float_lsp.show_references, { desc = "Goto References" })
map({ "n", "x" }, "gt", float_lsp.show_type_definition, { desc = "Goto Type Definitions" })
map({ "n", "x" }, "gd", float_lsp.show_definition, { desc = "Goto Definition" })
map({ "n", "x" }, "gI", float_lsp.show_implementation, { desc = "Goto Implementation" })
map({ "n", "x" }, "gb", vim.lsp.buf.document_symbol, { desc = "Goto Symbol" })
map({ "n", "x" }, "gB", vim.lsp.buf.workspace_symbol, { desc = "Goto Symbol(Workspace)" })

map({ "n", "x" }, "<leader>d", function()
	vim.diagnostic.open_float({ source = true })
end, { desc = "[D]iagnostics" })

map({ "n", "x" }, "<leader>rn", vim.lsp.buf.rename, { desc = "ReName" })

-- Normal
map("n", "<C-q>", ":q<cr>")
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>")
map("n", "<C-h>", "<C-w>h", { desc = "Goto left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Goto bellow window" })
map("n", "<C-k>", "<C-w>k", { desc = "Goto above window" })
map("n", "<C-l>", "<C-w>l", { desc = "Goto right window" })
map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear highlight" })
map("n", "<C-=>", window.previous_win, { desc = "Previous Window" })
map("n", "<C-p>", window.pick_win, { desc = "Pick Window" })
map("n", "<C-w>r", window.toggle_orientation, { desc = "Rotate Window" })
map("n", "<C-w>c", window.remove_win_buf, { desc = "Close Window" })
map("n", "<C-w>C", window.hide_win, { desc = "Hide Window" })
map("n", "<C-w><C-w>", window.previous_win, { desc = "Select Previous Window" })
map("n", "<cr>", "a<Cr><Esc>")
map("n", "<S-cr>", "i<Cr><Esc>")
map("n", "<leader>w", "<cmd>wa<cr>", { desc = "Write All" })
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>bd", buffer.delete_buffer, { desc = "Buffer Delete" })
map("n", "<leader>bo", buffer.delete_other_buffers, { desc = "Buffer Delete Other" })
map("n", "<leader>bc", function()
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.bo[buf].buftype == "acwrite" then
			vim.api.nvim_buf_delete(buf, {})
		end
	end
end, { desc = "Clear acwrite buffers" })
map("n", "<leader>p", '"+p', { desc = "Paste from Clipboard" })
map("n", "<leader>P", '"+P', { desc = "Paste from Clipboard" })
map("n", "<leader>ll", "<cmd>copen<cr>", { desc = "List Quickfix" })
map("n", "<leader>lc", git.conflict_list, { desc = "List Git Conflict" })
map("n", "<leader>ld", diagnostic.current_buf_list, { desc = "List Diagnostics" })
map("n", "<leader>lD", diagnostic.workspace_list, { desc = "List Diagnostics(Workspace)" })
map("n", "<C-e>", register.edit_register, { desc = "Edit Register" })
map("n", "<leader>tq", ":tabclose<cr>", { desc = "Quite tab and buffers" })

-- Insert and Cmdline
map({ "i", "c" }, "<C-h>", "<BS>")
map({ "i", "c" }, "<C-d>", "<Delete>")
map({ "i", "c" }, "<C-a>", "<Home>")
map({ "i", "c" }, "<C-e>", "<End>")
map({ "i", "c" }, "<C-f>", "<Right>")
map({ "i", "c" }, "<C-b>", "<Left>")
map({ "i", "c" }, "<C-r><C-r>", "<C-r>0")

-- Insert
map("i", "<C-l>", "<Esc>la")
map("i", "<C-n>", "<Down>")
map("i", "<C-p>", "<Up>")
map("i", "<C-k>", "<C-o>d$")

-- Visual
map("x", "y", "ygv<Esc>")

-- Terminal
map("t", "<C-\\><Esc>", "<C-\\><C-n>")
map("t", "<C-\\>q", "<C-\\><C-n>:q<cr>")
map("t", "<C-space>", input.open_input, { desc = "Open Floating Input Window" })
