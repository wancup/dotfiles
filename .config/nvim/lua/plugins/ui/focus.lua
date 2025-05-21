local disabled_fts = {
	"alpha",
	"aerial",
	"neotest-summary",
	"neotest-output",
	"neotest-output-panel",
	"toggleterm",
	"gitsigns-blame",
}
local disabled_bts = { "prompt", "popup" }

return {
	"nvim-focus/focus.nvim",
	version = false,
	event = { "WinNew" },
	keys = {
		{
			"<leader>uf",
			function()
				vim.cmd("FocusEnable")
				vim.cmd("FocusAutoresize")
			end,
			desc = "Focus Resize",
		},
	},
	opts = {
		enable = true,
		autoresize = {
			enable = true,
		},
	},
	config = function(_, opts)
		local augroup = vim.api.nvim_create_augroup("FocusDisable", { clear = true })
		vim.api.nvim_create_autocmd("WinEnter", {
			group = augroup,
			callback = function(_)
				if
					vim.tbl_contains(disabled_fts, vim.bo.filetype)
					or vim.tbl_contains(disabled_bts, vim.bo.buftype)
				then
					vim.w.focus_disable = true
				else
					vim.w.focus_disable = false
				end
			end,
		})

		vim.api.nvim_create_autocmd("FileType", {
			group = augroup,
			callback = function(_)
				if
					vim.tbl_contains(disabled_fts, vim.bo.filetype)
					or vim.tbl_contains(disabled_bts, vim.bo.buftype)
				then
					vim.b.focus_disable = true
				else
					vim.b.focus_disable = false
				end
			end,
		})
		require("focus").setup(opts)
	end,
}
