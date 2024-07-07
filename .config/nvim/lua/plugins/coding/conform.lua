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
				markdown = { { "dprint", "prettierd", "prettier" } },
				yaml = { { "dprint", "prettierd", "prettier" } },
				json = { { "dprint", "prettierd", "prettier" } },
				css = { { "dprint", "prettierd", "prettier" } },
				toml = { { "dprint" } },
				javascript = { { "dprint", "prettierd", "prettier" }, "eslint_d" },
				javascriptreact = { { "dprint", "prettierd", "prettier" }, "eslint_d" },
				typescript = { { "dprint", "prettierd", "prettier" }, "eslint_d" },
				typescriptreact = { { "dprint", "prettierd" }, "eslint_d" },
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
