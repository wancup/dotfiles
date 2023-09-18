local map = vim.keymap.set

-- Normal
map("n", "<S-h>", "^")
map("n", "<S-l>", "$")
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>")
map("n", "<leader><leader>q", "<cmd>q<cr>")
map("n", "<leader><leader>h", "<C-w>h")
map("n", "<leader><leader>j", "<C-w>j")
map("n", "<leader><leader>k", "<C-w>k")
map("n", "<leader><leader>l", "<C-w>l")
map("n", "<leader>Fe", ":<C-u>!eslint_d --fix %; prettierd --write %<cr>", { desc = "[F]ix [E]slint" })
map("n", "<leader>o", "<cmd>wa<cr>", { desc = "Write All" })
map("n", "<leader>q", "<cmd>qa<cr>", { desc = "Quit All" })
map("n", "<leader>bd", "<cmd>bd<cr>", { desc = "[B]uffer [D]elete" })

-- Visual
map("x", "<S-h>", "^")
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
