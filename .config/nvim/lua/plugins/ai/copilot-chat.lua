return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			"github/copilot.vim",
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
			"CopilotChatFixDiagnostic",
			"CopilotChatCommit",
			"CopilotChatCommitStaged",
		},
		opts = {
			prompts = {
				Explain = {
					prompt = "/COPILOT_EXPLAIN 選択しているコードの説明を段落分けした文章で説明してください。",
				},
				Review = {
					prompt = "/COPILOT_REVIEW 選択したコードをレビューしてください。",
				},
				Fix = {
					prompt = "/COPILOT_GENERATE このコードには問題があります。バグを修正したコードを書いてください。",
				},
				Optimize = {
					prompt = "/COPILOT_GENERATE 選択したコードのパフォーマンスと可読性を改善してください。",
				},
				Docs = {
					prompt = "/COPILOT_GENERATE このセクションにドキュメントコメントを追加してください。",
				},
				Tests = {
					prompt = "/COPILOT_GENERATE このコードのテストを生成してください。",
				},
				FixDiagnostic = {
					prompt = "このファイルについての以下のdiagnosticsの問題を解説し、修正したコード案を提示してください。",
				},
				Commit = {
					prompt = "コミットメッセージを書いてください。メッセージはすべてをgitcommit形式のコードブロックとしてラップしてください。",
				},
				CommitStaged = {
					prompt = "コミットメッセージを書いてください。メッセージはすべてをgitcommit形式のコードブロックとしてラップしてください。",
				},
			},
		},
	},
}
