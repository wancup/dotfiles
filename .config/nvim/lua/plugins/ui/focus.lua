local disabled_fts = { "neo-tree" }
local disabled_bts = { "nofile", "prompt", "popup" }

return {
	"nvim-focus/focus.nvim",
	version = false,
	event = { "WinNew" },
	keys = {
		{ "<leader>uf", "<cmd>FocusAutoresize<cr>", desc = "[U]I [F]ocus Resize" },
	},
	opts = {
		enable = true,
		autoresize = {
			enable = true,
		},
		ui = {
			number = true,
			relativenumber = true,
			hybridnumber = true,
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
					require("focus").focus_disable()
				else
					require("focus").focus_enable()
				end
			end,
		})
		require("focus").setup(opts)
	end,
}
