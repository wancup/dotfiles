return {
	{
		"vim-skk/skkeleton",
		cond = true,
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			"vim-denops/denops.vim",
		},
		config = function()
			vim.keymap.set({ "i", "c", "t" }, "<c-j>", "<Plug>(skkeleton-enable)")

			vim.fn["skkeleton#config"]({
				eggLikeNewline = true,
				globalDictionaries = { "~/.local/share/skk/SKK-JISYO.L" },
				immediatelyCancel = false,
				userDictionary = "~/.local/state/skkeleton",
			})
			vim.fn["skkeleton#register_kanatable"]("rom", {
				-- [" "] = { "　" }, -- skkleton issue 183
				["("] = { "（" },
				[")"] = { "）" },
			})
			vim.fn["skkeleton#initialize"]()
		end,
	},
}
