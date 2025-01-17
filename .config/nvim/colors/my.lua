-- WIP: deep blossom
local set_hl = vim.api.nvim_set_hl

local palette = {
	base = "#18151c",
	sakura = "#d8c9d3",
	fuji = "#e3bbe9",
	ajisai = "#c69df2",
	odo = "#dc9497",
	daidai = "#d47672",
	star = "#f0e8b2",
	white = "#eeeeee",
	dim = "#939393",
	error = "#ff3f00",
	warning = "#ffba00",
}

set_hl(0, "Normal", { fg = palette.sakura, bg = palette.base })
set_hl(0, "NormalNC", { fg = palette.sakura, bg = palette.base })
set_hl(0, "NormalFloat", { fg = palette.sakura, bg = palette.base })

set_hl(0, "Comment", { fg = palette.dim })
set_hl(0, "String", { fg = palette.sakura })
set_hl(0, "Constant", { fg = palette.daidai })
set_hl(0, "Identifier", { fg = palette.fuji })
set_hl(0, "Function", { fg = palette.star })
set_hl(0, "Statement", { fg = palette.odo })
set_hl(0, "PreProc", { fg = palette.ajisai, bold = true })
set_hl(0, "Type", { fg = palette.ajisai })
set_hl(0, "Special", { fg = palette.ajisai })
set_hl(0, "Underline", { fg = palette.warning })
set_hl(0, "Ignore", { fg = palette.dim })
set_hl(0, "Error", { fg = palette.error })
set_hl(0, "Todo", { fg = palette.warning })
