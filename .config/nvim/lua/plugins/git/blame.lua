return {
	"FabijanZulj/blame.nvim",
	keys = {
		{ "<leader>g<leader>", "<cmd>BlameToggle<cr>", desc = "[G]it [B]lame Toggle" },
	},
	opts = {
		date_format = "%Y-%m-%d",
		mappings = {
			close = { "q" },
		},
	},
}
