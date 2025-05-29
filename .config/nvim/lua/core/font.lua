local M = {}

-- Avoid to invalid ambiwidth chars display
M.apply_cellwidths = function()
	vim.fn.setcellwidths({
		{ 0x1F000, 0x1FFFF, 2 }, -- 🀀 ~ 🫸
		{ 0x2190, 0x2193, 2 }, -- ← ~ ↓
		{ 0x2025, 0x2026, 2 }, -- ‥ ~ …
		{ 0x2460, 0x2473, 2 }, -- ① ~ ⑳
		{ 0x2600, 0x27FF, 2 }, -- ☀ ~ ⛿
		{ 0x2B05, 0x2B07, 2 }, -- ⬅ ~ ⬇
		{ 0x25BC, 0x25BD, 2 }, -- ▼ ~ ▽
	})
end

return M
