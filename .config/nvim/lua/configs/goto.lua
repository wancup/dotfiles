local git = require("core.git")

---@param key string
---@param cb function
---@param desc string
local function map(key, cb, desc)
	vim.keymap.set({ "n", "x" }, key, cb, { desc = desc })
end

local function prev_diagnostic()
	vim.diagnostic.goto_prev({ float = true })
end
local function next_diagnostic()
	vim.diagnostic.goto_next({ float = true })
end

---@param reverse boolean
local function goto(reverse)
	local current_motion = vim.g.current_motion_type
	if current_motion == nil then
		return
	end
	if reverse then
		if current_motion == "c" then
			git.prev_conflict()
		elseif current_motion == "C" then
			git.next_conflict()
		elseif current_motion == "d" then
			prev_diagnostic()
		elseif current_motion == "D" then
			next_diagnostic()
		elseif current_motion == "q" then
			vim.cmd("cprev")
		elseif current_motion == "Q" then
			vim.cmd("cnext")
		end
	else
		if current_motion == "c" then
			git.next_conflict()
		elseif current_motion == "C" then
			git.prev_conflict()
		elseif current_motion == "d" then
			next_diagnostic()
		elseif current_motion == "D" then
			prev_diagnostic()
		elseif current_motion == "q" then
			vim.cmd("cnext")
		elseif current_motion == "Q" then
			vim.cmd("cprev")
		end
	end
end

---@param identifyer string | nil
local function set_and_goto(identifyer)
	vim.g.current_motion_type = identifyer
	goto(false)
end

map("<C-,>", function()
	goto(true)
end, "Repeat prev motion")
map("<C-;>", function()
	goto(false)
end, "Repeat prev reversed motion")

map("[c", function()
	set_and_goto("C")
end, "Goto Previous Conflict")
map("]c", function()
	set_and_goto("c")
end, "Goto Next Conflict")

map("[d", function()
	set_and_goto("D")
end, "Goto Previous Diagnostic")
map("]d", function()
	set_and_goto("d")
end, "Goto Next Diagnostic")

map("[q", function()
	set_and_goto("Q")
end, "Goto Previous Quickfix")
map("]q", function()
	set_and_goto("q")
end, "Goto Next Quickfix")
