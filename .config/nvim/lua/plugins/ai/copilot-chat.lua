return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "main",
	dependencies = {
		"github/copilot.vim",
		"nvim-lua/plenary.nvim",
	},
	init = function()
		vim.api.nvim_create_user_command("CC", function()
			vim.cmd("CopilotChat")
		end, {})
	end,
	cmd = {
		"CopilotChat",
		"CopilotChatOpen",
		"CopilotChatReset",
		"CopilotChatExplain",
		"CopilotChatReview",
		"CopilotChatFix",
		"CopilotChatOptimize",
		"CopilotChatDocs",
		"CopilotChatTests",
		"CopilotChatExplainDiagnostic",
		"CopilotChatFixDiagnostic",
		"CopilotChatCommit",
		"CopilotChatCommitStaged",
	},
	keys = {
		{ "<leader>aa", "<cmd>CopilotChat<cr>", desc = "CopilotChat" },
		{ "<leader>af", "<cmd>CopilotChatFix<cr>", desc = "CopilotChatFix" },
	},
	opts = {
		prompts = {
			Explain = {
				prompt = "選択しているコードの説明を段落分けした文章で説明してください。",
				system_prompt = "COPILOT_EXPLAIN",
			},
			Review = {
				prompt = "選択したコードをレビューしてください。",
				system_prompt = "COPILOT_REVIEW",
			},
			Fix = {
				prompt = "このコードには問題があります。バグを修正したコードを書いてください。",
			},
			Optimize = {
				prompt = "選択したコードのパフォーマンスと可読性を改善してください。",
			},
			Docs = {
				prompt = "このセクションにドキュメントコメントを追加してください。",
			},
			Tests = {
				prompt = "このコードのテストを生成してください。",
			},
			ExplainDiagnostic = {
				prompt = "このファイルについてのdiagnosticsの問題を解説してください。",
				system_prompt = "COPILOT_EXPLAIN",
			},
			FixDiagnostic = {
				prompt = "このファイルについてのdiagnosticsの問題を修正したコード案を提示してください。",
			},
			Commit = {
				prompt = "#git:staged\n\nコミットメッセージを書いてください。メッセージはすべてをgitcommit形式のコードブロックとしてラップしてください。",
			},
		},
		mappings = {
			reset = {
				normal = "<S-BS>",
				insert = false,
			},
		},
	},
}
