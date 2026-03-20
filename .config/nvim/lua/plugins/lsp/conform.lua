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
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	opts = {
		formatters = {
			prettier = {
				require_cwd = true,
			},
			prettierd = {
				require_cwd = true,
			},
		},
		formatters_by_ft = {
			lua = { "stylua" },
			fish = { "fish_indent" },
			dart = { "dart_format" },
			markdown = {
				"prettierd",
				"prettier",
				stop_after_first = true,
				lsp_format = "first",
			},
			yaml = {
				"prettierd",
				"prettier",
				stop_after_first = true,
				lsp_format = "first",
			},
			json = {
				"prettierd",
				"prettier",
				stop_after_first = true,
				lsp_format = "first",
			},
			jsonc = {
				"prettierd",
				"prettier",
				stop_after_first = true,
				lsp_format = "first",
			},
			css = {
				"prettierd",
				"prettier",
				stop_after_first = true,
				lsp_format = "first",
			},
			astro = function(bufnr)
				return {
					get_available_formatter(bufnr, "prettierd", "prettier"),
					"eslint_d",
					lsp_format = "first",
				}
			end,
			javascript = function(bufnr)
				return {
					get_available_formatter(bufnr, "prettierd", "prettier"),
					"eslint_d",
					lsp_format = "first",
				}
			end,
			javascriptreact = function(bufnr)
				return {
					get_available_formatter(bufnr, "prettierd", "prettier"),
					"eslint_d",
					lsp_format = "first",
				}
			end,
			typescript = function(bufnr)
				return {
					get_available_formatter(bufnr, "prettierd", "prettier"),
					"eslint_d",
					lsp_format = "first",
				}
			end,
			typescriptreact = function(bufnr)
				return {
					get_available_formatter(bufnr, "prettierd", "prettier"),
					"eslint_d",
					lsp_format = "first",
				}
			end,
			go = { "gofmt" },
			rust = { "rustfmt" },
			python = { "ruff_format", "ruff_fix" },
			terraform = { "tofu_fmt" },
			["terraform-vars"] = { "tofu_fmt" },
		},
		format_on_save = function()
			if vim.g.format_on_save then
				return {
					timeout_ms = 5000,
					lsp_format = "fallback",
				}
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
}
