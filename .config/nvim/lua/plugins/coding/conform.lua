return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				dart = { "dart_format" },
				markdown = { { "prettierd", "prettier" } },
				yaml = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				css = { { "prettierd", "prettier" } },
				javascript = { { "prettierd", "prettier" }, "eslint_d" },
				javascriptreact = { { "prettierd", "prettier" }, "eslint_d" },
				typescript = { { "prettierd", "prettier" }, "eslint_d" },
				typescriptreact = { { "prettierd", "prettier" }, "eslint_d" },
			},
			format_on_save = function()
				if vim.g.format_on_save then
					return { timeout_ms = 1000, lsp_fallback = false }
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
