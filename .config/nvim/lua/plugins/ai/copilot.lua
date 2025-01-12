return {
	"github/copilot.vim",
	cmd = { "Copilot" },
	init = function()
		vim.g.copilot_enabled = false
		vim.g.copilot_no_tab_map = true

		vim.keymap.set("i", "<C-Cr>", 'copilot#Accept("")', {
			expr = true,
			replace_keycodes = false,
		})
	end,
}
