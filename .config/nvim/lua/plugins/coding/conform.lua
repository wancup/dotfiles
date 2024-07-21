---@param bufnr integer
---@param ... string
---@return string
local function get_available_formatter(bufnr, ...)
	local conform = require("conform")
	for i = 1, select("#", ...) do
		local formatter = select(i, ...)
		if conform.get_formatter_info(formatter, bufnr).available then
			return formatter
		end
	end
	return select(-1, ...)
end

return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		opts = {
			formatters = {
				dprint = {
					require_cwd = true,
				},
			},
			formatters_by_ft = {
				lua = { "stylua" },
				dart = { "dart_format" },
				dockerfile = { "dprint" },
				markdown = { "dprint", "prettierd", "prettier", stop_after_first = true },
				yaml = { "dprint", "prettierd", "prettier", stop_after_first = true },
				json = { "dprint", "prettierd", "prettier", stop_after_first = true },
				css = { "dprint", "prettierd", "prettier", stop_after_first = true },
				toml = { "dprint" },
				javascript = function(bufnr)
					return { get_available_formatter(bufnr, "dprint", "prettierd", "prettier"), "eslint_d" }
				end,
				javascriptreact = function(bufnr)
					return { get_available_formatter(bufnr, "dprint", "prettierd", "prettier"), "eslint_d" }
				end,
				typescript = function(bufnr)
					return { get_available_formatter(bufnr, "dprint", "prettierd", "prettier"), "eslint_d" }
				end,
				typescriptreact = function(bufnr)
					return { get_available_formatter(bufnr, "dprint", "prettierd", "prettier"), "eslint_d" }
				end,
				rust = { "rustfmt" },
				python = { "ruff_format", "ruff_fix" },
			},
			format_on_save = function()
				if vim.g.format_on_save then
					return { timeout_ms = 5000, lsp_fallback = false }
				end
			end,
		},
		init = function()
			vim.g.format_on_save = true
			vim.api.nvim_create_user_command("FormatOff", function()
				vim.g.format_on_save = false
			end, {
				desc = "Disable format-on-save",
				force = true,
			})
			vim.api.nvim_create_user_command("FormatOn", function()
				vim.g.format_on_save = true
			end, {
				desc = "Enable format-on-save",
				force = true,
			})

			vim.api.nvim_create_user_command("Format", function()
				require("conform").format({ async = true })
			end, {
				desc = "Format by conform",
				force = true,
			})
		end,
	},
}
