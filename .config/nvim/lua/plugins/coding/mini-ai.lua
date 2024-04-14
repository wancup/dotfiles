return {
	{
		"echasnovski/mini.ai",
		version = false,
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local gen_spec = require("mini.ai").gen_spec
			require("mini.ai").setup({
				search_method = "cover",
				custom_textobjects = {
					[" "] = { "[,.({].-[,.)};]", "^().().*().()$" },
					["r"] = gen_spec.pair("/", "/"),
				},
			})
		end,
	},
}
