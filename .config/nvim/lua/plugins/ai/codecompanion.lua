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
			mode = { "n", "x" },
		},
	},
	opts = {
		strategies = {
			chat = {
				adapter = "copilot",
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
					modes = { "v" },
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

							return "以下の文章を日本語に翻訳してください。\n\n" .. text .. "\n"
						end,
					},
				},
			},
		},
	},
	init = function()
		vim.cmd([[cab cc CodeCompanion]])

		local group = vim.api.nvim_create_augroup("CodeCompanionNotification", {})

		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = "CodeCompanionRequestStarted",
			callback = function()
				vim.notify("[CodeCompanion] Request Started!")
			end,
		})

		-- Hello, World!
		vim.api.nvim_create_autocmd("User", {
			group = group,
			pattern = "CodeCompanionRequestFinished",
			callback = function()
				vim.notify("[CodeCompanion] Request Finished!")
			end,
		})
	end,
}
