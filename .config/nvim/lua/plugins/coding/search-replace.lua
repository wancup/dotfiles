-- Better Replace
return {
	{
		"roobert/search-replace.nvim",
		keys = {
			{ "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", desc = "[R]eplace[S]ection" },
			{ "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>", desc = "[R]eplace[O]pen" },
			{ "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", desc = "[R]eplace[W]ord" },
			{ "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", desc = "[R]eplace[W]ORD" },
			{ "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", desc = "[R]eplace[E]xpr" },
			{ "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>", desc = "[R]eplace[F]ile" },

			{ "<leader>rbs", "<CMD>SearchReplaceMultiBufferSelections<CR>", desc = "[R]eplaceMulti[B]uffer[S]ection" },
			{ "<leader>rbo", "<CMD>SearchReplaceMultiBufferOpen<CR>", desc = "[R]eplaceMulti[B]uffer[O]pen" },
			{ "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWord<CR>", desc = "[R]eplaceMulti[B]uffer[W]ord" },
			{ "<leader>rbW", "<CMD>SearchReplaceMultiBufferCWORD<CR>", desc = "[R]eplaceMulti[B]uffer[W]ORD" },
			{ "<leader>rbe", "<CMD>SearchReplaceMultiBufferCExpr<CR>", desc = "[R]eplaceMulti[B]uffer[E]xpr" },
			{ "<leader>rbf", "<CMD>SearchReplaceMultiBufferCFile<CR>", desc = "[R]eplaceMulti[B]uffer[F]ile" },
		},
		config = true,
	},
}
