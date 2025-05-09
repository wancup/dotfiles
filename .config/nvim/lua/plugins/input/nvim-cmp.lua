return {
	"hrsh7th/nvim-cmp",
	version = false,
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/cmp-nvim-lsp-signature-help",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local mapping = {
			["<C-d>"] = cmp.mapping(cmp.mapping.abort(), { "i", "s", "c" }),
			["<C-k>"] = cmp.mapping(
				cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				{ "i", "s", "c" }
			),
			["<C-j>"] = cmp.mapping(
				cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				{ "i", "s", "c" }
			),
			["<C-space>"] = cmp.mapping.complete({
				config = {
					sources = { { name = "nvim_lsp" } },
				},
			}),
			["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i", "s", "c" }),
		}

		cmp.setup({
			sources = {
				{ name = "luasnip" },
				{ name = "nvim_lsp" },
				{ name = "nvim_lsp_signature_help" },
			},
			completion = { completeopt = "menu,menuone,noinsert" },
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
			mapping = mapping,
			formatting = {
				format = require("lspkind").cmp_format({
					mode = "symbol",
					maxwidth = {
						menu = function()
							return math.floor(0.3 * vim.api.nvim_win_get_width(0))
						end,
						abbr = function()
							return math.floor(0.4 * vim.api.nvim_win_get_width(0))
						end,
					},
					ellipsis_char = "…",
				}),
			},
		})

		cmp.setup.cmdline(":", {
			completion = { completeopt = "menu,menuone,noselect" },
			mapping = mapping,
			sources = cmp.config.sources({
				{ name = "cmdline" },
			}),
			matching = { disallow_symbol_nonprefix_matching = false },
		})

		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
	end,
}
