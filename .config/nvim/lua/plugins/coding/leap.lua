-- Easy Jump
return {
	{
		"ggandor/leap.nvim",
		keys = { "S", "s" },
		config = function()
			local leap = require("leap")
			leap.add_default_mappings()
			leap.opts.highlight_unlabeled_phase_one_targets = true
			vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
		end,
	},
}
