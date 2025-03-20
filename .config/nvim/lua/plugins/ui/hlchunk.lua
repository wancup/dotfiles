local CHUNK_HILIGH_COLOR = "#b080cc"

return {
	"shellRaining/hlchunk.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		chunk = {
			enable = true,
			delay = 100,
			style = {
				{ fg = CHUNK_HILIGH_COLOR },
				{ fg = "#d91d2f" },
			},
		},
		line_num = {
			enable = true,
			style = { CHUNK_HILIGH_COLOR },
			use_treesitter = true,
		},
	},
}
