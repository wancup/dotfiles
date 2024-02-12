-- Better Window Focus
return {
	{
		"4513ECHO/vim-snipewin",
		keys = {
			{
				"<C-w><C-p>",
				function()
					require("snipewin").select(vim.fn["g:snipewin#callback#goto"])
				end,
				desc = "[P]ick Window",
			},
			{
				"<C-w><C-c>",
				function()
					require("snipewin").select(vim.fn["g:snipewin#callback#close"])
				end,
				desc = "[C]lose Window",
			},
		},
		config = function()
			vim.g.snipewin_label_chars = "FJDKSLAHGQWERTYUIOZXCVBNM"
		end,
	},
}
