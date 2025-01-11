return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		keys = {
			{ "<leader>T", "<cmd>ToggleTerm<cr>", desc = "Toggle[T]erm" },
			{
				"<leader>gg",
				function()
					local Terminal = require("toggleterm.Terminal").Terminal
					local lazygit = Terminal:new({
						cmd = "lazygit",
						direction = "float",
					})
					lazygit:toggle()
				end,
				desc = "lazygit",
			},
			{
				"<leader>gl",
				function()
					local Terminal = require("toggleterm.Terminal").Terminal
					local file_path = vim.fn.expand("%:p")
					local lazygit = Terminal:new({
						cmd = "lazygit --filter '" .. file_path .. "'",
						direction = "float",
					})
					lazygit:toggle()
				end,
				desc = "[G]it [L]og Current File",
			},
		},
		opts = {
			float_opts = {
				width = math.floor(vim.o.columns * 0.95),
				height = math.floor(vim.o.lines * 0.95),
			},
		},
	},
}
