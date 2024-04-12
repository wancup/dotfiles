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
			should_autosave = function()
				if vim.tbl_contains(disabled_fts, vim.bo.filetype) then
					return false
				end
				return true
			end,
		},
	},
}
