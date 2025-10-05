return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	lazy = false,
	config = function()
		require("nvim-treesitter").setup()

		require("nvim-treesitter").install({
			"vim",
			"vimdoc",
			"fish",
			"bash",
			"markdown",
			"markdown_inline",
			"terraform",
			"dockerfile",
			"json",
			"toml",
			"yaml",
			"css",
			"html",
			"javascript",
			"tsx",
			"typescript",
			"lua",
			"go",
			"rust",
			"python",
		})
	end,
}
