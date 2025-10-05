local chat_model = os.getenv("CODECOMPANION_CHAT_MODEL")

return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	cmd = {
		"CodeCompanion",
		"CodeCompanionActions",
		"CodeCompanionChat",
	},
	keys = {
		{
			"<leader>a<leader>",
			"<cmd>CodeCompanionActions<cr>",
			desc = "Open CodeCompanion Action Palette",
			mode = { "n", "x" },
		},
		{ "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Toggle CodeCompanion", mode = { "n" } },
		{
			"<leader>aa",
			":'<,'>CodeCompanionChat Add<cr>",
			desc = "Add selection to CodeCompanion Chat",
			mode = { "x" },
		},
		{ "<leader>al", ":'<,'>CodeCompanion<cr>", desc = "Open Inline CodeCompanion", mode = { "n", "x" } },
		{
			"<leader>ai",
			":'<,'>CodeCompanion Implement<cr>",
			desc = "Implement with CodeCompanion",
			mode = { "n", "x" },
		},
		{
			"<leader>at",
			":'<,'>CodeCompanion /translate<cr>",
			desc = "Translare text to Japanese",
			mode = { "x" },
		},
		{
			"<leader>an",
			":'<,'>CodeCompanion /naming<cr>",
			desc = "Naming with CodeCompanion",
			mode = { "n" },
		},
	},
	opts = {
		strategies = {
			chat = {
				adapter = chat_model and {
					name = "copilot",
					model = chat_model,
				} or "copilot",
				keymaps = {
					clear = { modes = { n = "<S-BS>" } },
					stop = { modes = { n = "<C-c>", i = "<C-c>" } },
					close = { modes = { n = "<C-S-c>", i = "<C-S-c>" } },
				},
			},
			inline = {
				adapter = "copilot",
			},
			cmd = {
				adapter = "copilot",
			},
		},
		display = {
			chat = {
				show_header_separator = true,
				show_settings = true,
				window = {
					layout = "horizontal",
					opts = {
						number = false,
					},
				},
			},
			diff = {
				enabled = false,
			},
		},
		memory = {
			opts = {
				chat = {
					enabled = true,
				},
			},
		},
		opts = {
			language = "Japanese",
		},
		prompt_library = {
			["Translate"] = {
				strategy = "chat",
				description = "Translate text to Japanese",
				opts = {
					short_name = "translate",
					modes = { "x" },
					auto_submit = true,
					user_prompt = false,
					stop_context_insertion = true,
				},
				prompts = {
					{
						role = "system",
						content = "あなたは英語と日本語に精通した翻訳家です。",
					},
					{
						role = "user",
						content = function(context)
							local text =
								require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)

							return "以下の文章を翻訳してください。元の文章が英語の場合は日本語に、元が日本語の場合は英語に翻訳してください。\n\n"
								.. text
								.. "\n"
						end,
					},
				},
			},

			["Naming"] = {
				strategy = "chat",
				description = "Naming suggestion",
				opts = {
					short_name = "naming",
					modes = { "n" },
					auto_submit = true,
					user_prompt = true,
					stop_context_insertion = true,
				},
				prompts = {
					{
						role = "system",
						content = "あなたは英語と日本語に精通しているプロのプログラマーです。",
					},
					{
						role = "user",
						content = "以下の言葉をプログラミングで使用するとき、その命名案を複数出力してください。",
					},
				},
			},
		},
	},
	init = function()
		vim.cmd([[cab cc CodeCompanion]])

		local group = vim.api.nvim_create_augroup("CodeCompanionEventsFn", {})

		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = "CodeCompanionRequestStarted",
			callback = function()
				vim.api.nvim_command("stopinsert")
				vim.notify("[CodeCompanion] Request Started")
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = "CodeCompanionRequestStreaming",
			callback = function()
				vim.notify("[CodeCompanion] Request Streaming...")
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = "CodeCompanionRequestFinished",
			callback = function()
				vim.notify("[CodeCompanion] Request Finished!")
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = "CodeCompanionChatOpened",
			callback = function()
				vim.cmd("wincmd J")
				vim.cmd("FocusAutoresize")
			end,
		})
	end,
}
