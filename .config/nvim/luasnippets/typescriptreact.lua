local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local extras = require("luasnip.extras")
local l = extras.lambda
local fmt = require("luasnip.extras.fmt").fmt

return {
	-- React
	s(
		"nrfc",
		fmt(
			'import {{ type ReactElement }} from "react";\n\ninterface {Name}Props {{\n{}\n}}\n\nexport function {}(props: {Name}Props): ReactElement{{\nreturn (\n{}\n)\n}}',
			{
				i(2),
				i(1, "name"),
				i(3),
				Name = l(l._1, 1),
			}
		)
	),

	s(
		"rfc",
		fmt("function {}({}): ReactElement{{\nreturn (\n{}\n)\n}}", {
			i(1, "name"),
			i(2),
			i(3),
		})
	),

	s(
		"erfc",
		fmt("export function {}({}): ReactElement{{\nreturn (\n\n)\n}}", {
			i(1, "name"),
			i(2),
		})
	),

	s(
		"us",
		fmt("const [{}, set{State}] = useState({});", {
			i(1, "state"),
			i(2),
			State = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), 1),
		})
	),

	s(
		"ue",
		fmt("useEffect(() => {{\n{}\n}}, [{}])", {
			i(1),
			i(2),
		})
	),

	s("uc", { t('"use client"') }),

	s("cn", fmt("className={{{}}}", { i(1) })),

	-- Solid
	s(
		"nsfc",
		fmt(
			'import {{ type JSX }} from "solid-js";\n\ninterface {Name}Props {{}}\n\nexport function {}(props: {Name}Props): JSX.Element{{\nreturn (\n{}\n)\n}}',
			{
				i(1, "name"),
				i(2),
				Name = l(l._1, 1),
			}
		)
	),

	s(
		"sfc",
		fmt("function {}(props: {{{}}}): JSX.Element{{\nreturn (\n{}\n)\n}}", {
			i(1, "name"),
			i(2),
			i(3),
		})
	),

	s(
		"cs",
		fmt("const [{}, set{State}] = createSignal({});", {
			i(1, "state"),
			i(2),
			State = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), 1),
		})
	),

	s(
		"cm",
		fmt("const {} = createMemo(() => {})", {
			i(1),
			i(2),
		})
	),

	s(
		"ce",
		fmt("createEffect(() => {{\n{}\n}})", {
			i(1),
		})
	),

	s("class", { t("class=") }),

	s(
		"om",
		fmt("onMount(() => {{\n{}\n}})", {
			i(1),
		})
	),
}
