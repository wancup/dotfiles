local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		"fn",
		fmt("function {}({}) {{\n}}", {
			i(1, "name"),
			i(2, ""),
		})
	),

	s(
		"efn",
		fmt("export function {}({}) {{\n}}", {
			i(1, "name"),
			i(2, ""),
		})
	),

	s(
		"afn",
		fmt("async function {}({}) {{\n}}", {
			i(1, "name"),
			i(2, ""),
		})
	),

	s(
		"eafn",
		fmt("export async function {}({}) {{\n}}", {
			i(1, "name"),
			i(2, ""),
		})
	),

	s(
		"mfn",
		fmt("{}({}) {{\n}}", {
			i(1, "name"),
			i(2, ""),
		})
	),

	s(
		"mafn",
		fmt("async {}({}) {{\n}}", {
			i(1, "name"),
			i(2, ""),
		})
	),

	s(
		"arr",
		fmt("const {} = ({}) => {{\n}}", {
			i(1, "name"),
			i(2, ""),
		})
	),

	s(
		"aarr",
		fmt("const {} = async ({}) => {{\n}}", {
			i(1, "name"),
			i(2, ""),
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
		fmt("try {{{}\n}} catch(e) {{\n}}", {
			i(1),
		})
	),

	s(
		"class",
		fmt("class {} {{\n}}", {
			i(1),
		})
	),

	s(
		"classe",
		fmt("class {} extends {} {{\n}}", {
			i(1),
			i(2),
		})
	),

	s(
		"eclass",
		fmt("export class {} {{\n}}", {
			i(1),
		})
	),

	s(
		"eclasse",
		fmt("export class {} extends {} {{\n}}", {
			i(1),
			i(2),
		})
	),

	s(
		"for",
		fmt("for (let {i} = {}; {i} {}; {}) {{\n}}", {
			i = i(1, "i"),
			i(2),
			i(3),
			i(4, "++i"),
		})
	),

	s(
		"forof",
		fmt("for (const {} of {}) {{\n}}", {
			i(1, "item"),
			i(2, "iterable"),
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
		"tt",
		fmt('test("{}", ({}) => {{\n}})', {
			i(1),
			i(2),
		})
	),

	s(
		"tta",
		fmt('test("{}", async ({}) => {{\n}})', {
			i(1),
			i(2),
		})
	),

	s(
		"cb",
		fmt("({}) => {{\n}}", {
			i(1),
		})
	),

	s(
		"cbs",
		fmt("({}) => {}", {
			i(1),
			i(2),
		})
	),

	s(
		"acb",
		fmt("async ({}) => ({})", {
			i(1),
			i(2),
		})
	),

	s(
		"acbs",
		fmt("async ({}) => {}", {
			i(1),
			i(2),
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

	s("ec", { t("export const") }),

	s("co", { t('import "client-only"') }),

	s("so", { t('import "server-only"') }),
}
