return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	version = "2.*",
	keys = {
		{
			"<tab>",
			function()
				local luasnip = require("luasnip")
				if luasnip.jumpable(1) then
					luasnip.jump(1)
				end
				return "<tab>"
			end,
			mode = { "i", "s" },
			expr = true,
		},
		{
			"<S-tab>",
			function()
				local luasnip = require("luasnip")
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				end
				return "<S-tab>"
			end,
			mode = { "i", "s" },
			expr = true,
		},
	},
	config = function()
		require("luasnip").filetype_extend("typescriptreact", { "typescript" })
		require("luasnip.loaders.from_lua").lazy_load()
	end,
}
