-- Bufferline
return {
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		keys = {
			{ "<leader><S-h>", "<Cmd>BufferLineCyclePrev<CR>" },
			{ "<leader><S-l>", "<Cmd>BufferLineCycleNext<CR>" },
			{ "<leader>bp", "<Cmd>BufferLinePick<CR>", desc = "[B]uffer [P]ick" },
			{ "<leader>bc", "<Cmd>BufferLinePickClose<CR>", desc = "[B]uffer Pick [C]lose" },
			{ "<leader>bt", "<Cmd>BufferLineTogglePin<CR>", desc = "[B]uffer [T]oggle Pin" },
			{ "<leader>bH", "<Cmd>BufferLineCloseLeft<CR>", desc = "[B]uffer Close Left" },
			{ "<leader>bL", "<Cmd>BufferLineCloseRight<CR>", desc = "[B]uffer Close Right" },
			{ "<leader>bO", "<Cmd>BufferLineCloseOthers<CR>", desc = "[B]uffer Close [O]thers" },
			{ "<leader>bh", "<Cmd>BufferLineMovePrev<CR>", desc = "[B]uffer Move Left" },
			{ "<leader>bl", "<Cmd>BufferLineMoveNext<CR>", desc = "[B]uffer Move Right" },
		},
		opts = {
			options = {
				always_show_bufferline = false,
				diagnostics = "nvim_lsp",
				offsets = {
					{
						filetype = "neo-tree",
						text = "Neo-tree",
						highlight = "Directory",
					},
				},
			},
		},
	},
}
