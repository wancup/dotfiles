return {
	"folke/sidekick.nvim",
	keys = {
		{
			"<c-.>",
			function()
				require("sidekick.cli").toggle()
			end,
			desc = "Sidekick Toggle",
			mode = { "n", "t", "i", "x" },
		},
		{
			"<leader>as",
			function()
				require("sidekick.cli").send({ msg = "{this}" })
			end,
			mode = { "x", "n" },
			desc = "sidekick Send This",
		},
		{
			"<leader>af",
			function()
				require("sidekick.cli").send({ msg = "{file}" })
			end,
			desc = "sidekick Send File",
		},
		{
			"<leader>av",
			function()
				require("sidekick.cli").send({ msg = "{selection}" })
			end,
			mode = { "x" },
			desc = "Send Visual Selection",
		},
		{
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
		-- Example of a keybinding to open Claude directly
		{
			"<leader>ac",
			function()
				require("sidekick.cli").toggle({ name = "claude", focus = true })
			end,
			desc = "Sidekick Toggle Claude",
		},
		{
			"<leader>ag",
			function()
				require("sidekick.cli").toggle({ name = "copilot", focus = true })
			end,
			desc = "Sidekick Toggle Copilot",
		},
	},
	opts = {
		cli = {
			win = {
				layout = "bottom",
				---@type table<string, sidekick.cli.Keymap|false>
				keys = {
					buffers = { "<C-S-b>", "buffers", mode = "nt", desc = "open buffer picker" },
					files = { "<C-S-f>", "files", mode = "nt", desc = "open file picker" },
					hide_n = { "q", "hide", mode = "n", desc = "hide the terminal window" },
					hide_ctrl_q = { "<c-q>", "hide", mode = "n", desc = "hide the terminal window" },
					hide_ctrl_dot = { "<c-.>", "hide", mode = "nt", desc = "hide the terminal window" },
					hide_ctrl_z = { "<c-z>", "hide", mode = "nt", desc = "hide the terminal window" },
					prompt = { "<C-S-p>", "prompt", mode = "t", desc = "insert prompt or context" },
					stopinsert = { "<Esc>", "stopinsert", mode = "t", desc = "enter normal mode" },
					nav_left = false,
					nav_down = false,
					nav_up = false,
					nav_right = false,
				},
			},
		},
	},
}
