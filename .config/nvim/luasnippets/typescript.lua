local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		"fn",
		fmt("function {}({}): {} {{\n}}", {
			i(1, "name"),
			i(2, "arguments"),
			i(3, "return_type"),
		})
	),

	s(
		"efn",
		fmt("export function {}({}): {} {{\n}}", {
			i(1, "name"),
			i(2, "arguments"),
			i(3, "return_type"),
		})
	),

	s(
		"afn",
		fmt("async function {}({}): Promise<{}> {{\n}}", {
			i(1, "name"),
			i(2, "arguments"),
			i(3, "return_type"),
		})
	),

	s(
		"eafn",
		fmt("export async function {}({}): Promise<{}> {{\n}}", {
			i(1, "name"),
			i(2, "arguments"),
			i(3, "return_type"),
		})
	),

	s(
		"arr",
		fmt("const {} = ({}): {} => {{\n}}", {
			i(1, "name"),
			i(2, "arguments"),
			i(3, "return_type"),
		})
	),

	s(
		"aarr",
		fmt("const {} = async ({}): Promise<{}> => {{\n}}", {
			i(1, "name"),
			i(2, "arguments"),
			i(3, "return_type"),
		})
	),

	s(
		"if",
		c(1, {
			fmt("if ({}) {{\n}}", {
				i(1),
			}),
			fmt("if ({}) {{\n}} else {{\n}}", {
				i(1),
			}),
		})
	),

	s(
		"try",
		fmt("try {{{}\n}} catch(e: unknown) {{\n}}", {
			i(1),
		})
	),

	s(
		"interface",
		c(1, {
			fmt("interface {} {{\n}}", {
				i(1),
			}),
			fmt("interface {} extends {} {{\n}}", {
				i(1),
				i(2),
			}),
		})
	),

	s(
		"class",
		c(1, {
			fmt("class {} {{\n}}", {
				i(1),
			}),
			fmt("class {} extends {} {{\n}}", {
				i(1),
				i(2),
			}),
		})
	),

	s(
		"for",
		c(1, {
			fmt("for (let {i} = {}; {i} {}; {}) {{\n}}", {
				i = i(1, "i"),
				i(2),
				i(3),
				i(4, "++i"),
			}),
			fmt("for (const {} of {}) {{\n}}", {
				i(1, "item"),
				i(2, "iteratable"),
			}),
		})
	),

	s(
		"switch",
		fmt("switch ({}) {{\n  case {}:\n    break;\n  default:\n}}", {
			i(1, "expr"),
			i(2, "value"),
		})
	),

	s(
		"while",
		fmt("while ({}) {{\n}}", {
			i(1),
		})
	),

	s(
		"describe",
		fmt('describe("{}", () => {{\n}})', {
			i(1),
		})
	),

	s(
		"it",
		fmt('it("{}", () => {{\n}})', {
			i(1),
		})
	),

	s(
		"test",
		fmt('test("{}", () => {{\n}})', {
			i(1),
		})
	),

	s(
		"cb",
		c(1, {
			fmt("({}) => {{\n}}", {
				i(1),
			}),
			fmt("({}) => ({})", {
				i(1),
				i(2),
			}),
		})
	),

	s(
		"acb",
		fmt("async ({}) => {{\n}}", {
			i(1),
		})
	),

	s(
		"tcb",
		fmt("({}) => {}", {
			i(1),
			i(2, "void"),
		})
	),

	s(
		"cl",
		fmt("console.log({})", {
			i(1),
		})
	),

	s(
		"ci",
		fmt("console.info({})", {
			i(1),
		})
	),

	s(
		"ce",
		fmt("console.error({})", {
			i(1),
		})
	),

	s(
		"cw",
		fmt("console.warn({})", {
			i(1),
		})
	),

	s(
		"eff",
		fmt('export {} from "{}"', {
			i(1, "*"),
			i(2),
		})
	),

	s("co", { t('import "client-only"') }),

	s("so", { t('import "server-only"') }),
}
