-- Better Window Focus
return {
	{
		"4513ECHO/vim-snipewin",
		keys = {
			{ "<C-w>p", "<Cmd>call snipewin#select(g:snipewin#callback#goto)<CR>", desc = "[P]ick Window" },
			{
				"<C-w>c",
				"<Cmd>call snipewin#select(g:snipewin#callback#close)<CR>",
				desc = "[C]lose Window",
			},
		},
		config = function()
			vim.g.snipewin_label_chars = "FJDKSLAHGQWERTYUIOZXCVBNM"
		end,
	},
}
