local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
	s(
		"```",
		fmt("```{}\n{}\n```", {
			i(1),
			i(2),
		})
	),

	s(
		"`sh",
		fmt("```sh\n{}\n```", {
			i(1),
		})
	),

	s(
		"`console",
		fmt("```console\n{}\n```", {
			i(1),
		})
	),

	s(
		"`javascript",
		fmt("```javascript\n{}\n```", {
			i(1),
		})
	),

	s(
		"`typescript",
		fmt("```typescript\n{}\n```", {
			i(1),
		})
	),

	s(
		"`css",
		fmt("```css\n{}\n```", {
			i(1),
		})
	),

	s(
		"`html",
		fmt("```html\n{}\n```", {
			i(1),
		})
	),

	s(
		"`rust",
		fmt("```rust\n{}\n```", {
			i(1),
		})
	),

	s(
		"`go",
		fmt("```go\n{}\n```", {
			i(1),
		})
	),
}
