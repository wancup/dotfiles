return {
	{
		"vim-skk/eskk.vim",
		cond = false,
		event = { "InsertEnter", "CmdlineEnter" },
		init = function()
			vim.g["eskk#directory"] = "~/.local/state/eskk"
			vim.g["eskk#dictionary"] = "~/.local/state/eskk/SKK-JISYO.user"
			vim.g["eskk#large_dictionary"] = "~/.local/share/skk/SKK-JISYO.L"
			vim.g["eskk#show_candidates_count"] = 4
			vim.g["eskk#show_annotation"] = 1
			vim.g["eskk#enable_completion"] = 0
			vim.g["eskk#egg_like_newline"] = 1
		end,
	},
}
