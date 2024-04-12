-- Session Manager
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
				local filetype = vim.bo.filetype
				if filetype == "alpha" or filetype == "lazy" then
					return false
				end
				return true
			end,
		},
	},
}
