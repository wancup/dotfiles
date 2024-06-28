-- Cursor Word Highlight
return {
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			min_count_to_highlight = 2,
			large_file_cutoff = 2000,
		},
		config = function(_, opts)
			require("illuminate").configure(opts)
		end,
	},
}
