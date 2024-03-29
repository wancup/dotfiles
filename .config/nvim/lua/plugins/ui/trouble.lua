-- Trouble
return {

	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		keys = {
			{ "<leader>ld", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "[L]ist [D]iagnostics" },
			{ "<leader>lD", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "[L]ist [D]iagnostics(Workspace)" },
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
