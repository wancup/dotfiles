return {
	{
		"echasnovski/mini.ai",
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mini.ai").setup({
				search_method = "cover",
				custom_textobjects = {
					[" "] = { "[,.({].-[,.)};]", "^().().*().()$" },
				},
			})
		end,
	},
}
