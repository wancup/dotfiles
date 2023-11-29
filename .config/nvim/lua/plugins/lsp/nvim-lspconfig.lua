-- LSP
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "Format", "Mason" },
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			{ "folke/neodev.nvim", config = true },
			"b0o/schemastore.nvim",
		},
		keys = {
			{ "<leader>Ff", "<cmd>Format<cr>", desc = "[F]ix [F]ormat" },

			-- Diagnostic
			{ "<leader>dl", vim.diagnostic.open_float, desc = "[D]iagnostics [L]ine" },
			{ "[d", vim.diagnostic.goto_prev, desc = "Prev [D]iagnostic" },
			{ "]d", vim.diagnostic.goto_next, desc = "Next [D]iagnostic" },

			-- Goto
			{ "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "[G]oto [D]efinition" },
			{ "gr", "<cmd>Telescope lsp_references<cr>", desc = "[G]oto [R]eferences" },
			{ "gD", vim.lsp.buf.declaration, desc = "[G]oto [D]eclaration" },
			{ "gI", "<cmd>Telescope lsp_implementations<cr>", desc = "[G]oto [I]mplementations" },
			{ "gt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "[G]oto [T]ype Definitions" },
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "gK", vim.lsp.buf.signature_help, desc = "Signature Help" },
		},
		config = function()
			vim.diagnostic.config({ underline = true, severity_sort = true })

			local on_attach = function(_, bufnr)
				vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
					vim.lsp.buf.format()
				end, {})
			end

			local default_capabilities = vim.lsp.protocol.make_client_capabilities()
			local capabilities = require("cmp_nvim_lsp").default_capabilities(default_capabilities)

			local server_settings = {
				lua_ls = {
					Lua = {
						workspace = { checkThirdParty = false },
						telemetry = { enable = false },
					},
				},

				jsonls = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},

				yamlls = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = require("schemastore").yaml.schemas({
							ignore = { "Deployer Recipe" },
						}),
					},
				},
			}

			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"jsonls",
					"yamlls",
					"taplo",
					"html",
					"cssls",
					"vtsls",
					"rust_analyzer",
				},
			})
			require("mason-lspconfig").setup_handlers({
				function(server)
					require("lspconfig")[server].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = server_settings[server],
					})
				end,
			})
		end,
	},
}
