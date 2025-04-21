return {
	"gbprod/yanky.nvim",
	event = { "BufReadPost", "BufNewFile" },
	keys = {
		{ "<leader>cp", "<cmd>YankyRingHistory<cr>", { desc = "Paste from Yanky" } },
	},
	opts = {},
}
