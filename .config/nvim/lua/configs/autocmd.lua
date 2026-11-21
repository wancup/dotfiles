local font = require("core/font")
local package_outdated = require("core/package-outdated")

local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd("FileType", {
	group = augroup("NvimTreeSitterStart"),
	callback = function()
		pcall(vim.treesitter.start)
		vim.treesitter.language.register("tsx", { "typescriptreact" })
	end,
})

-- Run the wildcard linter even when no FileType event is emitted.
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
	group = augroup("EfmWithoutFiletype"),
	callback = function(event)
		if vim.bo[event.buf].filetype == "" then
			local config = vim.deepcopy(vim.lsp.config.efm)
			if not config or type(config.root_dir) ~= "function" then
				return
			end
			config.root_dir(event.buf, function(root)
				config.root_dir = root
				vim.lsp.start(config, { bufnr = event.buf })
			end)
		end
	end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("PackageOutdated"),
	pattern = { "package.json", "pnpm-workspace.yaml" },
	callback = function(event)
		package_outdated.check(event.buf)
	end,
})

vim.api.nvim_create_autocmd("BufEnter", {
	group = augroup("RemoveAutoComment"),
	callback = function()
		-- avoid to automatic comment out
		vim.opt.formatoptions:remove("r")
		vim.opt.formatoptions:remove("o")
	end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = augroup("SetupTsc"),
	pattern = { "*.ts", "*.tsx" },
	callback = function()
		vim.cmd("compiler tsc")
		vim.opt.makeprg = "npx tsc --noEmit --skipLibCheck"
	end,
})

local force_single_width_fts = {
	"yazi",
	"toggleterm",
	"sidekick_terminal",
}
local reset_cellwidths_group = augroup("ResetCellWidths")
vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
	group = reset_cellwidths_group,
	callback = function(event)
		local filetype = vim.api.nvim_get_option_value("filetype", { buf = event.buf })
		if vim.tbl_contains(force_single_width_fts, filetype) then
			vim.fn.setcellwidths({})
		end
	end,
})

vim.api.nvim_create_autocmd("WinLeave", {
	group = reset_cellwidths_group,
	callback = function(event)
		if not vim.api.nvim_buf_is_valid(event.buf) then
			return
		end

		local filetype = vim.api.nvim_get_option_value("filetype", { buf = event.buf })
		if vim.tbl_contains(force_single_width_fts, filetype) then
			font.apply_cellwidths()
		end
	end,
})
