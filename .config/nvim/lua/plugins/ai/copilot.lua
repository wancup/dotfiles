return {
	"zbirenbaum/copilot.lua",
	cmd = { "Copilot" },
	event = { "InsertEnter" },
	keys = {
		{
			"<leader>ai",
			function()
				require("copilot.suggestion").toggle_auto_trigger()
			end,
			mode = { "n" },
			desc = "Toggle auto inline completion",
		},
	},
	opts = {
		panel = { enabled = false },
		suggestion = {
			enable = true,
			auto_trigger = false,
			keymap = {
				accept = "<C-cr>",
				accept_word = false,
				accept_line = false,
				next = "<C-;>",
				prev = "<C-,>",
			},
		},
	},
}
