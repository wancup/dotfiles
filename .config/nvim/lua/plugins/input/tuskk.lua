return {
	"kawarimidoll/tuskk.vim",
	cond = false,
	event = { "InsertEnter", "CmdlineEnter" },
	config = function()
		vim.keymap.set({ "i", "t" }, "<c-j>", vim.fn["tuskk#toggle"])
		vim.keymap.set({ "c" }, "<c-j>", vim.fn["tuskk#cmd_buf"])

		vim.fn["tuskk#initialize"]({
			user_jisyo_path = "~/.local/state/tuskk/SKK-JISYO.user",
			jisyo_list = {
				{ path = "~/.local/share/skk/SKK-JISYO.L", encoding = "euc-jp" },
			},
			kana_table = vim.fn["tuskk#opts#builtin_kana_table"](),
			merge_tsu = true,
			trailing_n = true,
			abbrev_ignore_case = true,
		})
	end,
}
