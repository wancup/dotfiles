local M = {}

local windows = {}
local processing = false

M.close_all_window = function()
	for _, win in ipairs(windows) do
		vim.api.nvim_win_close(win, false)
	end
	windows = {}
end

---@param item table
---@return integer
local function open_float_window(item)
	local bufnr = item.bufnr or vim.fn.bufadd(item.filename)
	local width = math.ceil(vim.o.columns * 0.7)
	local height = math.ceil(vim.o.lines * 0.4)
	local win = vim.api.nvim_open_win(bufnr, true, {
		relative = "cursor",
		width = width,
		height = height,
		row = 1,
		col = 0,
		border = "rounded",
		zindex = #windows + 1,
	})
	vim.api.nvim_win_set_buf(win, bufnr)
	vim.api.nvim_set_option_value("modifiable", false, { buf = bufnr })
	vim.api.nvim_win_set_cursor(win, { item.lnum, item.col - 1 })

	-- Keymap
	local set_keymap = function(key, callback)
		vim.keymap.set("n", key, callback, { buffer = bufnr, noremap = true, silent = true })
	end
	set_keymap("q", "<cmd>close<cr>")
	set_keymap("<cr>", function()
		M.close_all_window()
		vim.cmd("edit " .. item.filename)
	end)
	set_keymap("s", function()
		M.close_all_window()
		vim.cmd("split")
		vim.cmd("edit " .. item.filename)
	end)
	set_keymap("S", function()
		M.close_all_window()
		vim.cmd("vsplit")
		vim.cmd("edit " .. item.filename)
	end)

	-- Autoclose
	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = bufnr,
		callback = function()
			if processing then
				return
			end

			vim.api.nvim_buf_delete(bufnr, { force = false })
			table.remove(windows)
		end,
	})

	table.insert(windows, win)
	return win
end

local function handle_lsp_list(event)
	if #event.items == 1 then
		-- Save jumplist
		vim.cmd("normal! m'")

		-- Goto definition
		local item = event.items[1]
		local current_filename = vim.api.nvim_buf_get_name(0)
		if item.filename == current_filename then
			local win = vim.api.nvim_get_current_win()
			vim.api.nvim_win_set_cursor(win, { item.lnum, item.col - 1 })
		else
			open_float_window(item)
		end
	else
		vim.fn.setqflist({}, " ", { title = event.title, items = event.items })
		vim.cmd("botright copen")
	end
end

function M.show_references()
	processing = true
	vim.lsp.buf.references({ includeDeclaration = false }, {
		on_list = function(event)
			handle_lsp_list(event)
			processing = false
		end,
	})
end

function M.show_definition()
	processing = true
	vim.lsp.buf.definition({
		on_list = function(event)
			handle_lsp_list(event)
			processing = false
		end,
	})
end

function M.show_type_definition()
	processing = true
	vim.lsp.buf.type_definition({
		on_list = function(event)
			handle_lsp_list(event)
			processing = false
		end,
	})
end

function M.show_implementation()
	processing = true
	vim.lsp.buf.implementation({
		on_list = function(event)
			handle_lsp_list(event)
			processing = false
		end,
	})
end

return M
