local map = vim.keymap.set

-- Normal and Visual
map({ "n", "x" }, "<S-h>", "^")
map({ "n", "x" }, "<S-l>", "$")
map({ "n", "x" }, "<leader>y", '"+y', { desc = "[Y]ank to Clipboard" })

-- Normal
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>")
map("n", "<cr>", "a<Cr><Esc>")
map("n", "<S-cr>", "i<Cr><Esc>")
map("n", "<leader>w", "<cmd>wa<cr>", { desc = "Write All" })
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "[B]uffer [D]elete" })
map("n", "<leader>p", '"+p', { desc = "[P]aste from Clipboard" })
map("n", "<leader>P", '"+P', { desc = "[P]aste from Clipboard" })

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
map("i", "<C-r><C-r>", "<C-r>0")

-- Visual
map("x", "y", "ygv<Esc>")
