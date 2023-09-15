-- Better Rename
return {
	{
		"filipdutescu/renamer.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{ "<leader>rn", "<cmd>lua require('renamer').rename()<cr>", desc = "[R]e[N]ame" },
		},
		config = function()
			local mappings_utils = require("renamer.mappings.utils")
			require("renamer").setup({
				mappings = {
					["<c-i>"] = nil,
					["<c-a>"] = mappings_utils.set_cursor_to_start,
					["<c-e>"] = mappings_utils.set_cursor_to_end,
					["<c-b>"] = nil,
					["<c-c>"] = function()
						vim.api.nvim_input("<esc>")
					end,
					["<c-u>"] = mappings_utils.clear_line,
					["<c-r>"] = nil,
				},
			})
		end,
	},
}
