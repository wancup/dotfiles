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
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<tab>", true, false, true), "n", true)
				end
			end,
			mode = { "i", "s" },
		},
		{
			"<S-tab>",
			function()
				local luasnip = require("luasnip")
				if luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<S-tab>", true, false, true), "n", true)
				end
			end,
			mode = { "i", "s" },
		},
	},
	config = function()
		require("luasnip").filetype_extend("typescriptreact", { "typescript" })
		require("luasnip.loaders.from_lua").lazy_load()
	end,
}
