local git = require("core.git")
local window = require("core.window")
local map = vim.keymap.set

---@param cb function
local function goto_split(cb)
	vim.cmd("split")
	cb()
end

---@param cb function
local function goto_vsplit(cb)
	vim.cmd("vsplit")
	cb()
end

local function goto_split_ref()
	goto_split(vim.lsp.buf.references)
end
local function goto_vsplit_ref()
	goto_vsplit(vim.lsp.buf.references)
end

local function goto_type_def()
	vim.lsp.buf.type_definition({ reuse_win = true })
end
local function goto_split_type_def()
	goto_split(vim.lsp.buf.definition)
end
local function goto_vsplit_type_def()
	goto_vsplit(vim.lsp.buf.definition)
end

local function goto_def()
	vim.lsp.buf.definition({ reuse_win = true })
end
local function goto_split_def()
	goto_split(vim.lsp.buf.definition)
end
local function goto_vsplit_def()
	goto_vsplit(vim.lsp.buf.definition)
end

local function goto_split_impl()
	goto_split(vim.lsp.buf.implementation)
end
local function goto_vsplit_impl()
	goto_vsplit(vim.lsp.buf.implementation)
end

-- Normal and Visual
map({ "n", "x" }, "<S-h>", "^")
map({ "n", "x" }, "<S-l>", "$")
map({ "n", "x" }, "<leader>y", '"+y', { desc = "[Y]ank to Clipboard" })

map({ "n", "x" }, "K", vim.lsp.buf.hover, { desc = "Hover" })
map({ "n", "x" }, "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })

map({ "n", "x" }, "gr", vim.lsp.buf.references, { desc = "[G]oto [R]eferences" })
map({ "n", "x" }, "gsr", goto_split_ref, { desc = "[G]oto [S]plit [R]eferences" })
map({ "n", "x" }, "gSr", goto_vsplit_ref, { desc = "[G]oto [V]split [R]eferences" })

map({ "n", "x" }, "gt", goto_type_def, { desc = "[G]oto [T]ype Definitions" })
map({ "n", "x" }, "gst", goto_split_type_def, { desc = "[G]oto [S]plit [T]ype Defintions" })
map({ "n", "x" }, "gSt", goto_vsplit_type_def, { desc = "[G]oto [V]split [T]ype Defintions" })

map({ "n", "x" }, "gd", goto_def, { desc = "[G]oto [D]ifinition" })
map({ "n", "x" }, "gsd", goto_split_def, { desc = "[G]oto [S]plit [D]ifinition" })
map({ "n", "x" }, "gSd", goto_vsplit_def, { desc = "[G]oto [V]split [D]ifinition" })

map({ "n", "x" }, "gI", vim.lsp.buf.implementation, { desc = "[G]oto [I]mplementation" })
map({ "n", "x" }, "gsI", goto_split_impl, { desc = "[G]oto [S]plit [I]mplementation" })
map({ "n", "x" }, "gSI", goto_vsplit_impl, { desc = "[G]oto [V]split [I]mplementation" })

map({ "n", "x" }, "gb", vim.lsp.buf.document_symbol, { desc = "[G]oto Sym[b]ol" })
map({ "n", "x" }, "gB", vim.lsp.buf.workspace_symbol, { desc = "[G]oto Sym[b]ol(Workspace)" })

map({ "n", "x" }, "<leader>d", function()
	vim.diagnostic.open_float({ source = true })
end, { desc = "[D]iagnostics" })
map({ "n", "x" }, "[d", vim.diagnostic.goto_prev, { desc = "Prev [D]iagnostics" })
map({ "n", "x" }, "]d", vim.diagnostic.goto_next, { desc = "Next [D]iagnostics" })

map({ "n", "x" }, "[c", git.prev_conflict, { desc = "Goto Previous Conflict" })
map({ "n", "x" }, "]c", git.next_conflict, { desc = "Goto Next Conflict" })

map({ "n", "x" }, "[q", "<cmd>cprev<cr>", { desc = "Goto Previous Quickfix" })
map({ "n", "x" }, "]q", "<cmd>cnext<cr>", { desc = "Goto Next Quickfix" })

map({ "n", "x" }, "<leader>a", vim.lsp.buf.code_action, { desc = "Code [A]ction" })
map({ "n", "x" }, "<leader>rn", vim.lsp.buf.rename, { desc = "[R]e[N]ame" })

-- Normal
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>")
map("n", "<C-w>r", window.toggle_orientation, { desc = "[R]otate Window" })
map("n", "<C-w>p", window.pick_win, { desc = "[P]ick Window" })
map("n", "<C-w>c", window.remove_win_buf, { desc = "[C]lose Window" })
map("n", "<C-w>C", window.hide_win, { desc = "Hide Window" })
map("n", "<C-w>w", window.switch_win, { desc = "Switch Current Window" })
map("n", "<C-w><C-w>", window.switch_win, { desc = "Switch Current Window" })
map("n", "<cr>", "a<Cr><Esc>O")
map("n", "<S-cr>", "i<Cr><Esc>O")
map("n", "<leader>Fe", ":<C-u>!eslint_d --fix %; prettierd --write %<cr>", { desc = "[F]ix [E]slint" })
map("n", "<leader>w", "<cmd>wa<cr>", { desc = "Write All" })
map("n", "<leader><esc>", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "[B]uffer [D]elete" })
map("n", "<leader>p", '"+p', { desc = "[P]aste from Clipboard" })
map("n", "<leader>P", '"+P', { desc = "[P]aste from Clipboard" })
map("n", "<leader>ll", "<cmd>copen<cr>", { desc = "[L]ist Quickfix" })
map("n", "<leader>lc", git.conflict_list, { desc = "[L]ist Git [C]onflict" })

-- Insert
map("i", "<C-h>", "<BS>")
map("i", "<C-d>", "<Delete>")
map("i", "<C-j>", "<CR>")
map("i", "<C-k>", "<C-o>d$")
map("i", "<C-a>", "<Home>")
map("i", "<C-e>", "<End>")
map("i", "<C-n>", "<Down>")
map("i", "<C-p>", "<Up>")
map("i", "<C-f>", "<Right>")
map("i", "<C-b>", "<Left>")
