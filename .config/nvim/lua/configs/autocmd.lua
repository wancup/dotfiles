local font = require("../core/font")

local function augroup(name)
	return vim.api.nvim_create_augroup(name, { clear = true })
end

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
}
local reset_cellwidths_group = augroup("ResetCellWidths")
vim.api.nvim_create_autocmd("FileType", {
	group = reset_cellwidths_group,
	pattern = force_single_width_fts,
	callback = function()
		vim.fn.setcellwidths({})
	end,
})

vim.api.nvim_create_autocmd("WinClosed", {
	group = reset_cellwidths_group,
	callback = function(event)
		local win_id = tonumber(event.match)
		if not win_id then
			return
		end
		local buf = vim.api.nvim_win_get_buf(win_id)
		if (not buf) or (not vim.api.nvim_buf_is_valid(buf)) then
			return
		end

		local filetype = vim.api.nvim_get_option_value("filetype", { buf = buf })
		if vim.tbl_contains(force_single_width_fts, filetype) then
			font.apply_cellwidths()
		end
	end,
})
