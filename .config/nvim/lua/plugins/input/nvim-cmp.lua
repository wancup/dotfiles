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
		{ "zbirenbaum/copilot-cmp", dependencies = { "zbirenbaum/copilot.lua" }, config = true },
		{ "Dynge/gitmoji.nvim", opts = { completion = { append_space = true, complete_as = "emoji" } } },
	},
	config = function()
		local cmp = require("cmp")

		local luasnip = require("luasnip")

		local mapping = {
			["<C-d>"] = cmp.mapping(cmp.mapping.abort(), { "i", "s", "c" }),
			["<C-p>"] = cmp.mapping(
				cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				{ "i", "s", "c" }
			),
			["<C-n>"] = cmp.mapping(
				cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				{ "i", "s", "c" }
			),
			["<C-space>"] = cmp.mapping(function()
				cmp.complete({
					config = {
						sources = {
							{ name = "nvim_lsp", group_index = 1 },
							{ name = "nvim_lsp_signature_help", group_index = 1 },
						},
					},
				})
			end),
			["<C-,>"] = cmp.mapping(function()
				cmp.complete({
					config = {
						sources = { { name = "copilot" } },
					},
				})
			end),
			["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i", "s", "c" }),
		}

		cmp.setup({
			enabled = function()
				if vim.fn.exists("skkeleton#is_enabled") and vim.fn["skkeleton#is_enabled"]() then
					return false
				end
				local disabled = false

				disabled = disabled or (vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt")
				disabled = disabled or (vim.fn.reg_recording() ~= "")
				disabled = disabled or (vim.fn.reg_executing() ~= "")
				return not disabled
			end,
			sources = {
				{ name = "luasnip", group_index = 1 },
				{ name = "nvim_lsp", group_index = 1 },
				{ name = "nvim_lsp_signature_help", group_index = 1 },
				{ name = "copilot", group_index = 2 },
				per_filetype = {
					codecompanion = { "codecompanion" },
				},
			},
			completion = { completeopt = "menu,menuone,noinsert" },
			performance = {
				debounce = 10,
				throttle = 10,
			},
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
					mode = "symbol_text",
					symbol_map = { Copilot = "" },
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

		cmp.setup.cmdline({ "/", "?" }, {
			enabled = false,
		})

		cmp.setup.filetype("gitcommit", {
			sources = cmp.config.sources({
				{ name = "gitmoji" },
			}),
		})

		vim.lsp.config("*", {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})
	end,
}
