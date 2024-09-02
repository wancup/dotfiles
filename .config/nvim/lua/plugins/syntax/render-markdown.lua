return {
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = "markdown",
		keys = { { "<leader>um", "<cmd>RenderMarkdown toggle<cr>", desc = "[U]i [M]arkdown Render Toggle" } },
		opts = {
			enabled = false,
		},
	},
}
