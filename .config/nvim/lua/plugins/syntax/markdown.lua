return {
	{
		"MeanderingProgrammer/markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		name = "render-markdown",
		ft = "markdown",
		keys = { { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "[U]i [M]arkdown Render Toggle" } },
		opts = {
			enabled = false,
		},
	},
}
