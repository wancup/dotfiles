return {
	"previm/previm",
	ft = { "markdown", "mermaid" },
	init = function()
		vim.g.previm_open_cmd = "open -a Firefox"
	end,
}
