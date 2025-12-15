-- Bufferline
return {
	"akinsho/bufferline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	cond = false,
	keys = {
		{ "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Buffer Prev" },
		{ "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Buffer Next" },
		{ "<leader>bp", "<Cmd>BufferLinePick<CR>", desc = "Buffer Pick" },
		{ "<leader>bC", "<Cmd>BufferLinePickClose<CR>", desc = "Buffer Pick Close" },
		{ "<leader>bt", "<Cmd>BufferLineTogglePin<CR>", desc = "Buffer Toggle Pin" },
		{ "<leader>bH", "<Cmd>BufferLineCloseLeft<CR>", desc = "Buffer Close Left" },
		{ "<leader>bL", "<Cmd>BufferLineCloseRight<CR>", desc = "Buffer Close Right" },
		{ "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Buffer Close Others" },
		{ "<leader>bh", "<Cmd>BufferLineMovePrev<CR>", desc = "Buffer Move Left" },
		{ "<leader>bl", "<Cmd>BufferLineMoveNext<CR>", desc = "Buffer Move Right" },
	},
	opts = {
		options = {
			always_show_bufferline = false,
			diagnostics = "nvim_lsp",
		},
	},
}
