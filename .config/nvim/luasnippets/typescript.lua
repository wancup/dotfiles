local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "func",
    fmt(
      "function {}({}): {} {{\n}}", {
        i(1, "name"),
        i(2, "arguments"),
        i(3, "return_type"),
      })
  ),

  s(
    "efunc",
    fmt(
      "export function {}({}): {} {{\n}}", {
        i(1, "name"),
        i(2, "arguments"),
        i(3, "return_type"),
      })
  ),

  s(
    "afunc",
    fmt(
      "async function {}({}): Promise<{}> {{\n}}", {
        i(1, "name"),
        i(2, "arguments"),
        i(3, "return_type"),
      })
  ),

  s(
    "eafunc",
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
    "cb",
    fmt(
      "({}) => {{\n}}", {
        i(1),
      })
  ),

  s(
    "log",
    fmt(
      "console.log({})", {
        i(1),
      })
  ),
}
