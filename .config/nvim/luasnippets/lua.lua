local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		"M",
		fmt("local M = {{}}\n\n{}\n\nreturn M", {
			i(1),
		})
	),
}
