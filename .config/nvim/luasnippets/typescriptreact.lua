local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local extras = require("luasnip.extras")
local l = extras.lambda
local fmt = require("luasnip.extras.fmt").fmt

return {
  s(
    "nrfc",
    fmt(
    "import {{ ReactElement }} from \"react\";\n\ntype Props = {{}}\n\nfunction {}(props: Props): ReactElement{{\n}}", {
      i(1, "name"),
    })
  ),

  s(
    "rfc",
    fmt("function {}({}): ReactElement{{\n}}", {
      i(1, "name"),
      i(2, "props")
    })
  ),

  s(
    "uses",
    fmt("const [{}, set{State}] = useState({});", {
      i(1, "state"),
      i(2, "initialState"),
      State = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), 1)
    })
  ),

  s(
    "func",
    fmt(
      "function {}({}): {} {{\n}}", {
        i(1, "name"),
        i(2, "arguments"),
        i(3, "return_type"),
      })
  ),
}
