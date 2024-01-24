local eslint_config = ".eslintrc.*"
local prettier_config = { ".prettierrc", ".prettierrc.*", "prettier.config.*" }

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
				rust = formatters.lsp,
				lua = {
					formatters.if_file_exists({
						pattern = { "stylua.toml" },
						formatter = formatters.stylua,
					}),
				},
				markdown = {
					formatters.if_file_exists({
						pattern = prettier_config,
						formatter = formatters.prettierd,
					}),
				},
				yaml = {
					formatters.if_file_exists({
						pattern = prettier_config,
						formatter = formatters.prettierd,
					}),
				},
				json = {
					formatters.if_file_exists({
						pattern = prettier_config,
						formatter = formatters.prettierd,
					}),
				},
				javascript = {
					formatters.if_file_exists({
						pattern = eslint_config,
						formatter = formatters.eslint_d_fix,
					}),
					formatters.if_file_exists({
						pattern = prettier_config,
						formatter = formatters.prettierd,
					}),
				},
				javascriptreact = {
					formatters.if_file_exists({
						pattern = eslint_config,
						formatter = formatters.eslint_d_fix,
					}),
					formatters.if_file_exists({
						pattern = prettier_config,
						formatter = formatters.prettierd,
					}),
				},
				typescript = {
					formatters.if_file_exists({
						pattern = eslint_config,
						formatter = formatters.eslint_d_fix,
					}),
					formatters.if_file_exists({
						pattern = prettier_config,
						formatter = formatters.prettierd,
					}),
				},
				typescriptreact = {
					formatters.if_file_exists({
						pattern = eslint_config,
						formatter = formatters.eslint_d_fix,
					}),
					formatters.if_file_exists({
						pattern = prettier_config,
						formatter = formatters.prettierd,
					}),
				},
			},
		})
	end,
}
