return {
	{
		"MeanderingProgrammer/markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		name = "render-markdown",
		ft = "markdown",
		keys = { { "<leader>um", "<cmd>RenderMarkdownToggle<cr>", desc = "[U]i [M]arkdown Render Toggle" } },
		opts = {
			latex_enabled = false,
			max_file_size = 1,
		},
	},
}
