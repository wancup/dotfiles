local git = require("core.git")

---@param key string
---@param cb function
---@param desc string
local function map(key, cb, desc)
	vim.keymap.set({ "n", "x" }, key, cb, { desc = desc })
end

local function prev_diagnostic()
	vim.diagnostic.jump({ float = true, count = -1 })
end
local function next_diagnostic()
	vim.diagnostic.jump({ float = true, count = 1 })
end

local base_motion_map = {
	c = {
		forward = function()
			vim.cmd.normal({ "]c", bang = true })
		end,
		backward = function()
			vim.cmd.normal({ "[c", bang = true })
		end,
	},
	x = { forward = git.next_conflict, backward = git.prev_conflict },
	d = { forward = next_diagnostic, backward = prev_diagnostic },
	h = {
		forward = function()
			require("gitsigns").nav_hunk("next")
		end,
		backward = function()
			require("gitsigns").nav_hunk("prev")
		end,
	},
	q = { forward = "cnext", backward = "cprev" },
	t = {
		forward = function()
			require("todo-comments").jump_next()
		end,
		backward = function()
			require("todo-comments").jump_prev()
		end,
	},
}

local motion_map = {}
for id, motion in pairs(base_motion_map) do
	motion_map[id] = motion
	motion_map[id:upper()] = {
		forward = motion.backward,
		backward = motion.forward,
	}
end

---@param reverse boolean
local function do_motion(reverse)
	local current_motion = vim.g.current_motion_type
	if not current_motion then
		return
	end

	local motion = motion_map[current_motion]
	if not motion then
		return
	end

	if reverse then
		if type(motion.backward) == "string" then
			vim.cmd(motion.backward)
		else
			motion.backward()
		end
	else
		if type(motion.forward) == "string" then
			vim.cmd(motion.forward)
		else
			motion.forward()
		end
	end
end

---@param identifyer string | nil
local function set_and_goto(identifyer)
	vim.g.current_motion_type = identifyer
	do_motion(false)
end

map("<C-,>", function()
	do_motion(true)
end, "Repeat prev motion")
map("<C-;>", function()
	do_motion(false)
end, "Repeat prev reversed motion")

local motions = {
	{ key = "[c", id = "C", desc = "Goto Previous Diff" },
	{ key = "]c", id = "c", desc = "Goto Next Diff" },
	{ key = "[x", id = "X", desc = "Goto Previous Conflict" },
	{ key = "]x", id = "x", desc = "Goto Next Conflict" },
	{ key = "[d", id = "D", desc = "Goto Previous Diagnostic" },
	{ key = "]d", id = "d", desc = "Goto Next Diagnostic" },
	{ key = "[h", id = "H", desc = "Goto Previous Hunk" },
	{ key = "]h", id = "h", desc = "Goto Next Hunk" },
	{ key = "[q", id = "Q", desc = "Goto Previous Quickfix" },
	{ key = "]q", id = "q", desc = "Goto Next Quickfix" },
	{ key = "[t", id = "T", desc = "Goto Previous Todo" },
	{ key = "]t", id = "t", desc = "Goto Next Todo" },
}

for _, motion in ipairs(motions) do
	map(motion.key, function()
		set_and_goto(motion.id)
	end, motion.desc)
end
