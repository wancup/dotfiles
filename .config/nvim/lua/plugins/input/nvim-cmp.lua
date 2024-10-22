local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
	{
		"hrsh7th/nvim-cmp",
		version = false,
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-cmdline",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim",
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			local select_next = function(fallback)
				if luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				elseif cmp.visible() then
					cmp.select_next_item()
				elseif has_words_before() then
					cmp.complete()
				else
					fallback()
				end
			end

			local select_prev = function(fallback)
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				elseif cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end

			return {
				sources = {
					{ name = "luasnip" },
					{ name = "nvim_lsp" },
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
				mapping = cmp.mapping.preset.insert({
					["<tab>"] = cmp.mapping(select_next, { "i", "s" }),
					["<S-tab>"] = cmp.mapping(select_prev, { "i", "s" }),
					["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete({
						config = {
							sources = { { name = "nvim_lsp" } },
						},
					}),
					["<C-d>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = false }),
				}),
				formatting = {
					format = require("lspkind").cmp_format(),
				},
			}
		end,

		config = function(_, opts)
			local cmp = require("cmp")
			cmp.setup(opts)

			cmp.setup.cmdline(":", {
				completion = { completeopt = "menu,menuone,noselect" },
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = "cmdline" },
				}),
				matching = { disallow_symbol_nonprefix_matching = false },
			})
		end,
	},
}
