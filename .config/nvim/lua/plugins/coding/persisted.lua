local disabled_fts = {
	"alpha",
	"lazy",
	"",
}

return {
	{
		"olimorris/persisted.nvim",
		event = { "VimLeavePre" },
		cmd = { "SessionLoad", "SessionSave", "SessionToggle" },
		keys = {
			{ "<leader>St", "<cmd>SessionToggle<cr>", desc = "[S]ession [T]oggle" },
			{ "<leader>Ss", "<cmd>SessionSave<cr>", desc = "[S]ession [S]ave" },
			{ "<leader>Sl", "<cmd>SessionLoad<cr>", desc = "[S]ession [L]oad" },
		},
		opts = {
			should_save = function()
				if vim.tbl_contains(disabled_fts, vim.bo.filetype) then
					return false
				end
				if vim.fn.expand("%:p"):match("nvim%-clipboard/.*%.txt") then
					return false
				end
				return true
			end,
		},
	},
}
