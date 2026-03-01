local M = {}

function M.open_input()
	local current_win = vim.api.nvim_get_current_win()
	local input_buf = vim.api.nvim_create_buf(false, true)

	local float_width = math.floor(vim.o.columns * 0.5)
	local float_win = vim.api.nvim_open_win(input_buf, true, {
		relative = "win",
		win = current_win,
		row = -8,
		col = math.floor((vim.o.columns - float_width) / 2),
		width = float_width,
		height = 5,
		style = "minimal",
		border = "rounded",
	})

	vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = input_buf, noremap = true })
	vim.keymap.set({ "n", "i" }, "<C-s>", function()
		local lines = vim.api.nvim_buf_get_lines(input_buf, 0, -1, false)
		vim.fn.setreg('"', lines, "l")
		vim.api.nvim_set_current_win(current_win)
		vim.api.nvim_put(lines, "l", true, true)
		vim.api.nvim_win_close(float_win, true)
	end, { buffer = input_buf, noremap = true })

	vim.api.nvim_create_autocmd({ "WinClosed" }, {
		pattern = tostring(float_win),
		once = true,
		callback = function()
			if vim.api.nvim_buf_is_valid(input_buf) then
				vim.api.nvim_buf_delete(input_buf, { force = true })
			end
		end,
	})

	vim.schedule(function()
		vim.cmd("startinsert")
	end)
end

return M
