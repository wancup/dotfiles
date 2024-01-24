return {
	"elentok/format-on-save.nvim",
	event = "BufWritePre",
	cmd = { "Format", "FormatOn", "FormatOff" },
	config = function()
		local formatters = require("format-on-save.formatters")
		require("format-on-save").setup({
			exclude_path_patterns = {
				"/node_modules/",
			},
			formatter_by_ft = {
				lua = formatters.stylua,
				rust = formatters.lsp,
				json = formatters.prettierd,
				markdown = formatters.prettierd,
				javascript = formatters.prettierd,
				yaml = formatters.prettierd,
				typescript = {
					formatters.if_file_exists({
						pattern = ".eslintrc.*",
						formatter = formatters.eslint_d_fix,
					}),
					formatters.prettierd,
				},
				typescriptreact = {
					formatters.if_file_exists({
						pattern = ".eslintrc.*",
						formatter = formatters.eslint_d_fix,
					}),
					formatters.prettierd,
				},
			},
		})
	end,
}
