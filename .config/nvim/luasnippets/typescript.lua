local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node
local fmt = require("luasnip.extras.fmt").fmt

return {
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
    "efn",
    fmt(
      "export function {}({}): {} {{\n}}", {
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
    "eafn",
    fmt(
      "export async function {}({}): Promise<{}> {{\n}}", {
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
    "co",
    { t("import \"client-only\"") }
  ),

  s(
    "so",
    { t("import \"server-only\"") }
  ),
}
