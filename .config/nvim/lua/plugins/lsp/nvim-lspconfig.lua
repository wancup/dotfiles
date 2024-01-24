-- LSP
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		cmd = { "FormatByLsp", "Mason" },
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			{ "folke/neodev.nvim", config = true },
			"b0o/schemastore.nvim",
		},
		keys = {
			{ "<leader>Ff", "<cmd>FormatByLsp<cr>", desc = "[F]ix [F]ormat Using LSP" },
		},
		config = function()
			vim.diagnostic.config({ underline = true, severity_sort = true })

			local on_attach = function(_, bufnr)
				vim.api.nvim_buf_create_user_command(bufnr, "FormatByLsp", function(_)
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

			-- efm-langserver is installed by aqua
			require("lspconfig").efm.setup({
				init_options = {
					documentFormatting = true,
					documentRangeFormatting = true,
					codeAction = true,
				},
			})
		end,
	},
}
