-- Easy Jump
return {
	{
		"jinh0/eyeliner.nvim",
		keys = { "f", "F" },
		config = function()
			require("eyeliner").setup({
				highlight_on_key = true,
				dim = true,
			})
			vim.api.nvim_set_hl(0, "EyelinerDimmed", { link = "Comment" })
		end,
	},
}
