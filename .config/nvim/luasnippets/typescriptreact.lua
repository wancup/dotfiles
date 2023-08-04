local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local extras = require("luasnip.extras")
local l = extras.lambda
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "nrfc",
    fmt(
      "import {{ ReactElement }} from \"react\";\n\ninterface Props = {{}}\n\nexport function {}(props: Props): ReactElement{{\nreturn (\n\n)\n}}",
      {
        i(1, "name"),
      })
  ),

  s(
    "rfc",
    fmt("function {}({}): ReactElement{{\nreturn (\n\n)\n}}", {
      i(1, "name"),
      i(2, "props")
    })
  ),

  s(
    "erfc",
    fmt("export function {}({}): ReactElement{{\nreturn (\n\n)\n}}", {
      i(1, "name"),
      i(2, "props")
    })
  ),

  s(
    "us",
    fmt("const [{}, set{State}] = useState({});", {
      i(1, "state"),
      i(2, "initialState"),
      State = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), 1)
    })
  ),

  s(
    "fn",
    fmt(
      "function {}({}): {} {{\n}}", {
        i(1, "name"),
        i(2, "arguments"),
        i(3, "return_type"),
      })
  ),

  s(
    "afn",
    fmt(
      "async function {}({}): Promise<{}> {{\n}}", {
        i(1, "name"),
        i(2, "arguments"),
        i(3, "return_type"),
      })
  ),

  s(
    "arr",
    fmt(
      "const {} = ({}): {} => {{\n}}", {
        i(1, "name"),
        i(2, "arguments"),
        i(3, "return_type"),
      })
  ),

  s(
    "aarr",
    fmt(
      "const {} = async ({}): Promise<{}> => {{\n}}", {
        i(1, "name"),
        i(2, "arguments"),
        i(3, "return_type"),
      })
  ),

  s(
    "if",
    fmt(
      "if ({}) {{\n}}", {
        i(1),
      })
  ),

  s(
    "ife",
    fmt(
      "if ({}) {{\n}} else {{\n}}", {
        i(1),
      })
  ),

  s(
    "try",
    fmt(
      "try {{{}\n}} catch(e: unknown) {{\n}}", {
        i(1),
      })
  ),

  s(
    "cb",
    fmt(
      "({}) => {{\n}}", {
        i(1),
      })
  ),

  s(
    "acb",
    fmt(
      "async ({}) => {{\n}}", {
        i(1),
      })
  ),

  s(
    "cl",
    fmt(
      "console.log({})", {
        i(1),
      })
  ),

  s(
    "uc",
    { t("\"use client\"") }
  ),

  s(
    "co",
    { t("import \"client-only\"") }
  ),

  s(
    "so",
    { t("import \"server-only\"") }
  ),
}
