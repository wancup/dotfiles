return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	version = "2.*",
	keys = {
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
