return {
	"johmsalas/text-case.nvim",
	keys = {
		{
			"<leader>rs",
			"<CMD>lua require('textcase').lsp_rename('to_snake_case')<CR>",
			mode = { "n", "x" },
			desc = "to snake_case with lsp",
		},
		{
			"<leader>rk",
			"<CMD>lua require('textcase').lsp_rename('to_dash_case')<CR>",
			mode = { "n", "x" },
			desc = "to kebab-case with lsp",
		},
		{
			"<leader>rc",
			"<CMD>lua require('textcase').lsp_rename('to_camel_case')<CR>",
			mode = { "n", "x" },
			desc = "to camelCase with lsp",
		},
		{
			"<leader>rp",
			"<CMD>lua require('textcase').lsp_rename('to_pascal_case')<CR>",
			mode = { "n", "x" },
			desc = "to PascalCase with lsp",
		},
		{
			"<leader>rS",
			"<CMD>lua require('textcase').current_word('to_snake_case')<CR>",
			mode = { "n", "x" },
			desc = "to snake_case",
		},
		{
			"<leader>rK",
			"<CMD>lua require('textcase').current_word('to_dash_case')<CR>",
			mode = { "n", "x" },
			desc = "to kebab-case",
		},
		{
			"<leader>rC",
			"<CMD>lua require('textcase').current_word('to_camel_case')<CR>",
			mode = { "n", "x" },
			desc = "to camelCase",
		},
		{
			"<leader>rP",
			"<CMD>lua require('textcase').current_word('to_pascal_case')<CR>",
			mode = { "n", "x" },
			desc = "to PascalCase",
		},
	},
	opts = {
		default_keymappings_enabled = false,
	},
}
