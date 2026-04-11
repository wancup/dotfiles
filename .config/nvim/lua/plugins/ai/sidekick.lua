local default_cli_name = os.getenv("SIDEKICK_CLI_NAME")
local selected_cli_name = nil

return {
	"folke/sidekick.nvim",
	keys = {
		{
			"<tab>",
			function()
				-- if there is a next edit, jump to it, otherwise apply it if any
				if not require("sidekick").nes_jump_or_apply() then
					return "<Tab>" -- fallback to normal tab
				end
			end,
			expr = true,
		},
		{
			"<c-.>",
			function()
				local name = selected_cli_name or default_cli_name
				if name then
					require("sidekick.cli").toggle({ name = name })
				else
					require("sidekick.cli").toggle()
				end
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
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
		-- Example of a keybinding to open Claude directly
		{
			"<leader>a<leader>",
			function()
				require("sidekick.cli").select({
					cb = function(state)
						if state then
							selected_cli_name = state.tool.name
							require("sidekick.cli").focus({
								name = selected_cli_name,
							})
						end
					end,
				})
			end,
			desc = "Sidekick Select CLI",
		},
	},
	opts = {
		nes = {
			enabled = function()
				return vim.b.copilot_suggestion_auto_trigger or false
			end,
		},
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
					esc = {
						"<C-c><Esc>",
						function(term)
							vim.fn.chansend(term.job, "\x1b")
						end,
						mode = "t",
						desc = "send escape to terminal",
					},
					ctrl_c = {
						"<C-c><C-c>",
						function(term)
							vim.fn.chansend(term.job, "\x03")
						end,
						mode = "t",
						desc = "send C-c to terminal",
					},
					nav_left = false,
					nav_down = false,
					nav_up = false,
					nav_right = false,
				},
			},
		},
	},
}
