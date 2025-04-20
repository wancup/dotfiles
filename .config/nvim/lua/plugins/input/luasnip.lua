return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	version = "2.*",
	keys = {
		{
			"<C-n>",
			function()
				local ls = require("luasnip")
				if ls.choice_active() then
					ls.change_choice(1)
				end
			end,
			mode = { "i", "s" },
			desc = "select next snippet choice",
		},
		{
			"<C-p>",
			function()
				local ls = require("luasnip")
				if ls.choice_active() then
					ls.change_choice(-1)
				end
			end,
			mode = { "i", "s" },
			desc = "select prev snippet choice",
		},
		{
			"<tab>",
			function()
				require("luasnip").jump(1)
			end,
			mode = { "i", "s" },
		},
		{
			"<S-tab>",
			function()
				require("luasnip").jump(-1)
			end,
			mode = { "i", "s" },
		},
	},
	config = function()
		require("luasnip").filetype_extend("typescriptreact", { "typescript" })
		require("luasnip.loaders.from_lua").lazy_load()
	end,
}
