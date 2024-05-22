-- Auto Close Tags
return {
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPost", "BufNewFile" },
		config = true,
	},
}
