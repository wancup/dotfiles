local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

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

		local open_or_select_next = function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
			elseif has_words_before() then
				cmp.complete()
			else
				fallback()
			end
		end

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
			["<C-space>"] = cmp.mapping(open_or_select_next, { "i", "s", "c" }),
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
	end,
}
