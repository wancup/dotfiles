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
		require("mason-lspconfig").setup({
			ensure_installed = {
				"bashls",
				"lua_ls",
				"jsonls",
				"yamlls",
				"taplo",
				"html",
				"cssls",
			},
		})

		require("lspconfig").jsonls.setup({
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})

		require("lspconfig").yamlls.setup({
			settings = {
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

		vim.lsp.enable(require("mason-lspconfig").get_installed_servers())
	end,
}
