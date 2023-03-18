local map = vim.keymap.set

-- Normal
map("n", "j", "gj")
map("n", "k", "gk")
map("n", "<S-h>", "^")
map("n", "<S-j>", "}")
map("n", "<S-k>", "{")
map("n", "<S-l>", "$")

-- Visual
map("x", "<S-h>", "^")
map("x", "<S-j>", "}")
map("x", "<S-k>", "{")
map("x", "<S-l>", "$")

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
