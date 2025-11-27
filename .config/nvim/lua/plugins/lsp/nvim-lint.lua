return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lint = require("lint")
		lint.linters_by_ft = {
			fish = { "fish" },
			markdown = { "markdownlint" },
			dockerfile = { "hadolint" },
			astro = { "eslint_d" },
			javascript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescript = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			go = { "golangcilint" },
			rust = { "clippy" },
			["yaml.gha"] = { "actionlint" },
		}

		lint.linters.typos = require("lint.util").wrap(lint.linters.typos, function(diagnostic)
			diagnostic.severity = vim.diagnostic.severity.INFO
			return diagnostic
		end)

		vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "BufWritePost" }, {
			group = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
			callback = function()
				require("lint").try_lint()
				require("lint").try_lint("typos")
			end,
		})
	end,
}
