-- Better Window Focus
return {
	{
		"4513ECHO/vim-snipewin",
		keys = {
			{ "<leader><space>p", "<Cmd>call snipewin#select(g:snipewin#callback#goto)<CR>", desc = "[P]ick Window" },
			{
				"<leader><space>c",
				"<Cmd>call snipewin#select(g:snipewin#callback#close)<CR>",
				desc = "[C]lose Window",
			},
		},
		config = function()
			vim.g.snipewin_label_chars = "FJDKSLAHGQWERTYUIOZXCVBNM"
		end,
	},
}
