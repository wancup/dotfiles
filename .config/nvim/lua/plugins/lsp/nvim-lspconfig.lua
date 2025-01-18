-- LSP
return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	cmd = { "FormatByLsp", "Mason" },
	dependencies = {
		{ "williamboman/mason.nvim", config = true },
		"williamboman/mason-lspconfig.nvim",
		"b0o/schemastore.nvim",
	},
	keys = {
		{ "<leader>Ff", "<cmd>FormatByLsp<cr>", desc = "[F]ix [F]ormat Using LSP" },
	},
	config = function()
		vim.diagnostic.config({ underline = true, severity_sort = true })

		local _on_attach = function(_, _, bufnr)
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
				"bashls",
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
				-- Disable vtsls for flow
				if server == "vtsls" then
					local root_path = vim.fs.root(0, { ".flowconfig" })
					if root_path ~= nil then
						require("lspconfig").flow.setup({})
						return
					end
				end

				require("lspconfig")[server].setup({
					capabilities = capabilities,
					on_attach = function(client, buffnr)
						_on_attach(server, client, buffnr)
					end,
					settings = server_settings[server],
				})
			end,
		})

		-- Install Non-lsp deps
		local registry = require("mason-registry")
		for _, pkg_name in ipairs({ "eslint_d" }) do
			local ok, pkg = pcall(registry.get_package, pkg_name)
			if ok then
				if not pkg:is_installed() then
					vim.notify("Missing [" .. pkg.name .. "], installing...", vim.log.levels.INFO)
					pkg:install()
				end
			end
		end

		require("lspconfig").dprint.setup({})
	end,
}
