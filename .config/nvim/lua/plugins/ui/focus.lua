return {
	"nvim-focus/focus.nvim",
	version = "*",
	event = { "WinNew" },
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
				if vim.tbl_contains({ "neo-tree" }, vim.bo.filetype) then
					require("focus").focus_disable()
				else
					require("focus").focus_enable()
				end
			end,
		})
		require("focus").setup(opts)
	end,
}
