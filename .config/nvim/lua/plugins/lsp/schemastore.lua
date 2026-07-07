return {
	"b0o/schemastore.nvim",
	ft = { "json", "yaml", "yaml.gha" },
	config = function()
		vim.lsp.config("jsonls", {
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})

		vim.lsp.config("yamlls", {
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
	end,
}
