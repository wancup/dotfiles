local M = {}

M.edit_register = function()
	local reg = vim.v.register
	local current_content = vim.fn.getreg(reg)

	vim.ui.input({
		prompt = "Edit Register",
		default = current_content,
	}, function(input)
		if input ~= nil then
			vim.fn.setreg(reg, input)
		end
	end)
end

return M
