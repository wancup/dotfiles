return {
	"CopilotC-Nvim/CopilotChat.nvim",
	branch = "main",
	dependencies = {
		"zbirenbaum/copilot.lua",
		"nvim-lua/plenary.nvim",
	},
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
				prompt = "コミットメッセージを書いてください。メッセージはすべてをgitcommit形式のコードブロックとしてラップしてください。",
				context = "git:staged",
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
