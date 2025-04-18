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
			i(2, ""),
			i(3, "return_type"),
		})
	),

	s(
		"efn",
		fmt("export function {}({}): {} {{\n}}", {
			i(1, "name"),
			i(2, ""),
			i(3, "return_type"),
		})
	),

	s(
		"afn",
		fmt("async function {}({}): Promise<{}> {{\n}}", {
			i(1, "name"),
			i(2, ""),
			i(3, "return_type"),
		})
	),

	s(
		"eafn",
		fmt("export async function {}({}): Promise<{}> {{\n}}", {
			i(1, "name"),
			i(2, ""),
			i(3, "return_type"),
		})
	),

	s(
		"mfn",
		fmt("{}({}): {} {{\n}}", {
			i(1, "name"),
			i(2, ""),
			i(3, "return_type"),
		})
	),

	s(
		"mafn",
		fmt("async {}({}): {} {{\n}}", {
			i(1, "name"),
			i(2, ""),
			i(3, "return_type"),
		})
	),

	s(
		"arr",
		c(1, {
			fmt("const {} = ({}): {} => {{\n{}\n}}", {
				i(1, "name"),
				i(2, ""),
				i(3, "return_type"),
				i(4),
			}),
			fmt("const {} = ({}): {} => {}", {
				i(1, "name"),
				i(2, ""),
				i(3, "return_type"),
				i(4),
			}),
		})
	),

	s(
		"aarr",
		fmt("const {} = async ({}): Promise<{}> => {{\n}}", {
			i(1, "name"),
			i(2, ""),
			i(3, "return_type"),
		})
	),

	s(
		"if",
		fmt("if ({}) {{\n}}", {
			i(1),
		})
	),

	s(
		"ife",
		fmt("if ({}) {{\n}} else {{\n}}", {
			i(1),
		})
	),

	s(
		"ifr",
		fmt("if ({}) return {}", {
			i(1),
			i(2),
		})
	),

	s(
		"else",
		fmt("else {{\n{}\n}}", {
			i(1),
		})
	),

	s(
		"ei",
		fmt("else if({}) {{\n{}\n}}", {
			i(1),
			i(2),
		})
	),

	s(
		"try",
		fmt("try {{\n{}\n}} catch(e: unknown) {{\n{}\n}}", {
			i(1),
			i(2),
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
		"einterface",
		c(1, {
			fmt("export interface {} {{\n}}", {
				i(1),
			}),
			fmt("export interface {} extends {} {{\n}}", {
				i(1),
				i(2),
			}),
		})
	),

	s(
		"et",
		fmt("export type {} = {}", {
			i(1),
			i(2),
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
		"eclass",
		c(1, {
			fmt("export class {} {{\n}}", {
				i(1),
			}),
			fmt("export class {} extends {} {{\n}}", {
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
				i(2, "iterable"),
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
		"tt",
		c(1, {
			fmt('test("{}", ({}) => {{\n}})', {
				i(1),
				i(2),
			}),
			fmt('test("{}", async ({}) => {{\n}})', {
				i(1),
				i(2),
			}),
		})
	),

	s(
		"cb",
		c(1, {
			fmt("({}) => {{\n{}\n}}", {
				i(1),
				i(2),
			}),
			fmt("({}) => ({})", {
				i(1),
				i(2),
			}),
		})
	),

	s(
		"acb",
		c(1, {
			fmt("async ({}) => {{\n}}", {
				i(1),
			}),
			fmt("async ({}) => ({})", {
				i(1),
				i(2),
			}),
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
		"c.d",
		fmt("console.debug({})", {
			i(1),
		})
	),

	s(
		"c.l",
		fmt("console.log({})", {
			i(1),
		})
	),

	s(
		"c.i",
		fmt("console.info({})", {
			i(1),
		})
	),

	s(
		"c.e",
		fmt("console.error({})", {
			i(1),
		})
	),

	s(
		"c.w",
		fmt("console.warn({})", {
			i(1),
		})
	),

	s(
		"eff",
		fmt('export {} from "./{}"', {
			i(1, "*"),
			i(2),
		})
	),

	s("co", { t('import "client-only"') }),

	s("so", { t('import "server-only"') }),
}
