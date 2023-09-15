-- Better Increment/Decrement
return {

	{
		"monaqa/dial.nvim",
		keys = {
			{ "<C-a>", "<Plug>(dial-increment)", mode = { "n", "v" }, desc = "Increment" },
			{ "<C-x>", "<Plug>(dial-decrement)", mode = { "n", "v" }, desc = "Decrement" },
			{ "g<C-a>", "g<Plug>(dial-increment)", mode = { "n", "v" }, desc = "Increment" },
			{ "g<C-x>", "g<Plug>(dial-decrement)", mode = { "n", "v" }, desc = "Decrement" },
		},
		config = function()
			local augend = require("dial.augend")
			require("dial.config").augends:register_group({
				default = {
					augend.integer.alias.decimal,
					augend.date.alias["%Y/%m/%d"],
					augend.date.alias["%Y-%m-%d"],
					augend.semver.alias.semver,
					augend.constant.alias.bool,
					augend.constant.new({
						elements = { "&&", "||" },
						word = true,
						cyclic = true,
					}),
					augend.misc.alias.markdown_header,
				},
			})
		end,
	},
}
