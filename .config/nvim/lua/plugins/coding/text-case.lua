return {
	"johmsalas/text-case.nvim",
	keys = {
		{
			"<leader>cts",
			"<CMD>lua require('textcase').lsp_rename('to_snake_case')<CR>",
			mode = { "n", "x" },
			desc = "to snake_case with lsp",
		},
		{
			"<leader>ctk",
			"<CMD>lua require('textcase').lsp_rename('to_dash_case')<CR>",
			mode = { "n", "x" },
			desc = "to kebab-case with lsp",
		},
		{
			"<leader>ctc",
			"<CMD>lua require('textcase').lsp_rename('to_camel_case')<CR>",
			mode = { "n", "x" },
			desc = "to camelCase with lsp",
		},
		{
			"<leader>ctp",
			"<CMD>lua require('textcase').lsp_rename('to_pascal_case')<CR>",
			mode = { "n", "x" },
			desc = "to PascalCase with lsp",
		},
		{
			"<leader>ctS",
			"<CMD>lua require('textcase').current_word('to_snake_case')<CR>",
			mode = { "n", "x" },
			desc = "to snake_case",
		},
		{
			"<leader>ctK",
			"<CMD>lua require('textcase').current_word('to_dash_case')<CR>",
			mode = { "n", "x" },
			desc = "to kebab-case",
		},
		{
			"<leader>ctC",
			"<CMD>lua require('textcase').current_word('to_camel_case')<CR>",
			mode = { "n", "x" },
			desc = "to camelCase",
		},
		{
			"<leader>ctP",
			"<CMD>lua require('textcase').current_word('to_pascal_case')<CR>",
			mode = { "n", "x" },
			desc = "to PascalCase",
		},
	},
	opts = {
		default_keymappings_enabled = false,
	},
}
