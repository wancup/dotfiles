-- Better Window Focus
return {
	{
		"4513ECHO/vim-snipewin",
		event = { "WinNew" },
		keys = {
			{ "<C-w>p", "<Plug>(snipewin)", desc = "[P]ick Window" },
		},
		config = function()
			vim.g.snipewin_label_chars = "FJDKSLAHGQWERTYUIOZXCVBNM"
		end,
	},
}
