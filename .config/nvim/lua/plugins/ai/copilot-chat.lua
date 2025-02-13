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
	opts = {
		prompts = {
			Explain = {
				prompt = "> /COPILOT_EXPLAIN\n\n選択しているコードの説明を段落分けした文章で説明してください。",
			},
			Review = {
				prompt = "> /COPILOT_REVIEW\n\n選択したコードをレビューしてください。",
			},
			Fix = {
				prompt = "> /COPILOT_GENERATE\n\nこのコードには問題があります。バグを修正したコードを書いてください。",
			},
			Optimize = {
				prompt = "> /COPILOT_GENERATE\n\n選択したコードのパフォーマンスと可読性を改善してください。",
			},
			Docs = {
				prompt = "> /COPILOT_GENERATE\n\nこのセクションにドキュメントコメントを追加してください。",
			},
			Tests = {
				prompt = "> /COPILOT_GENERATE\n\nこのコードのテストを生成してください。",
			},
			ExplainDiagnostic = {
				prompt = "> /COPILOT_EXPLAIN\n\nこのファイルについてのdiagnosticsの問題を解説してください。",
			},
			FixDiagnostic = {
				prompt = "> /COPILOT_GENERATE\n\nこのファイルについてのdiagnosticsの問題を修正したコード案を提示してください。",
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
