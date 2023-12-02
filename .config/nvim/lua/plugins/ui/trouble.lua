-- Trouble
return {

	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		keys = {
			{ "<leader>Ld", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "[L]ist [D]iagnostics" },
			{ "<leader>LD", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "[L]ist [D]iagnostics(Workspace)" },
			{ "<leader>Lq", "<cmd>TroubleToggle quickfix<cr>", desc = "[L]ist [Q]uickfix" },
		},
		opts = {
			use_diagnostic_signs = true,
			action_keys = {
				jump = { "<C-j>", "<cr>", "<tab>" },
			},
			auto_close = true,
		},
	},
}
