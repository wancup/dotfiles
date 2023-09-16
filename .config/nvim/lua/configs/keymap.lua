local map = vim.keymap.set

-- Normal
map("n", "<S-h>", "^")
map("n", "<S-l>", "$")
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize +2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize -2<cr>")
map("n", "<leader>Fe", ":<C-u>!eslint_d --fix %; prettierd --write %<cr>", { desc = "[F]ix [E]slint" })
map("n", "<leader>o", "<cmd>w<cr>", { desc = "Write" })
map("n", "<leader>O", "<cmd>wa<cr>", { desc = "Write All" })
map("n", "<leader>q", "<cmd>bd<cr>", { desc = "Delete Buffer" })
map("n", "<leader>Q", "<cmd>qa<cr>", { desc = "Quit All" })

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
