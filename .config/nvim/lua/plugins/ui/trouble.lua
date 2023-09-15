-- Trouble
return {

	{
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		keys = {
			{ "<leader>dL", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "[D]iagnostics [L]ist" },
			{ "<leader>dW", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "[D]iagnostics [W]orkspace" },
			{ "<leader>qL", "<cmd>TroubleToggle quickfix<cr>", desc = "[Q]uickfix [L]ist" },
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
