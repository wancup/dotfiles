-- Toggle Comment
return {
	"numToStr/Comment.nvim",
	dependencies = {
		{
			"JoosepAlviste/nvim-ts-context-commentstring",
			opts = {
				enable_autocmd = false,
			},
		},
	},
	keys = {
		{ "<leader>/", "<Plug>(comment_toggle_linewise_current)", mode = { "n" }, desc = "Toggle Comment" },
		{
			"<leader>/",
			"<Plug>(comment_toggle_linewise_visual)",
			mode = { "x" },
			desc = "Toggle Selected Comment",
		},
	},
	opts = {
		mappings = false,
		pre_hook = function(...)
			local ok, ts_context = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
			if ok then
				return ts_context.create_pre_hook()(...)
			end
		end,
	},
}
