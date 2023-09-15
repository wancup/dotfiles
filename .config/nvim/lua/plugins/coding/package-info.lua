-- Node.js Packages
return {
	{
		"vuki656/package-info.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		ft = "json",
		opts = {
			package_manager = "pnpm",
		},
		keys = {
			{ "<leader>Nt", "<cmd>lua require('package-info').toggle()<cr>", desc = "[N]ode.js [T]oggle Info" },
			{ "<leader>Na", "<cmd>lua require('package-info').install()<cr>", desc = "[N]ode.js [A]dd Package" },
			{ "<leader>Nd", "<cmd>lua require('package-info').delete()<cr>", desc = "[N]ode.js [D]elete Package" },
			{
				"<leader>Nc",
				"<cmd>lua require('package-info').change_version()<cr>",
				desc = "[N]ode.js [C]hange Package Version",
			},
		},
	},
}
