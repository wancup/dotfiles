return {
	"zbirenbaum/copilot.lua",
	cmd = { "Copilot" },
	event = { "InsertEnter" },
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
