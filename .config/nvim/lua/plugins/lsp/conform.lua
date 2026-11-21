local enabled_autoformatting_ls = {
	"dprint",
	"oxfmt",
}

---@param bufnr integer
local function run_oxlint(bufnr)
	local client = vim.lsp.get_clients({ name = "oxlint", bufnr = bufnr })[1]
	if not client then
		return
	end

	local request_result = client:request_sync("workspace/executeCommand", {
		command = "oxc.fixAll",
		arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
	})
	if request_result and request_result.err then
		vim.notify(request_result.err.message, vim.log.levels.ERROR)
		return
	end
end

return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	init = function()
		vim.g.format_on_save = true
		vim.api.nvim_create_user_command("FormatOff", function()
			vim.g.format_on_save = false
		end, {
			desc = "Disable format-on-save",
			force = true,
		})
		vim.api.nvim_create_user_command("FormatOn", function()
			vim.g.format_on_save = true
		end, {
			desc = "Enable format-on-save",
			force = true,
		})

		vim.api.nvim_create_user_command("Format", function()
			require("conform").format()
		end, {
			desc = "Format by conform",
			force = true,
		})
	end,
	config = function()
		require("conform").setup({
			default_format_opts = {
				lsp_format = "fallback",
			},
			formatters_by_ft = {
				lua = { "stylua" },
				fish = { "fish_indent" },
				dart = { "dart_format" },
				go = { "gofmt" },
				rust = { "rustfmt" },
				python = { "ruff_format", "ruff_fix" },
				terraform = { "tofu_fmt" },
				["terraform-vars"] = { "tofu_fmt" },
			},
			format_on_save = function(bufnr)
				if vim.g.format_on_save then
					run_oxlint(bufnr)
					return {
						timeout_ms = 5000,
						filter = function(client)
							return vim.tbl_contains(enabled_autoformatting_ls, client.name)
						end,
					}
				end
			end,
		})
	end,
}
