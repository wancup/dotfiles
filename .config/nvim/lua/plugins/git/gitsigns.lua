-- Git Signs
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		attach_to_untracked = true,
		current_line_blame_opts = {
			delay = 100,
		},
		on_attach = function(buffer)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			end

			map("n", "<leader>ghp", function()
				gs.preview_hunk_inline()
			end, "Git Hunk Preview Inline")
			map("n", "<leader>ghP", gs.preview_hunk, "Git Hunk Preview")
			map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Git Hunk Stage")
			map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Git Hunk Reset")
			map("n", "<leader>gbs", gs.stage_buffer, "Git Buffer Stage")
			map("n", "<leader>gbr", gs.reset_buffer, "Git Buffer Reset")
			map("n", "<leader>gm", function()
				gs.blame()
			end, "Git blame")
			map("n", "<leader>gM", function()
				gs.blame_line({ full = true })
			end, "Git blame in line")

			-- Quickfix
			map("n", "<leader>lg", gs.setqflist, "List Git Hunks")
			map("n", "<leader>lG", function()
				gs.setqflist("all")
			end, "List Git All Hunks")

			-- Text Object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
		end,
	},
}
