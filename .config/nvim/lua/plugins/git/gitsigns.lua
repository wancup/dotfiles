-- Git Signs
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		current_line_blame_opts = {
			delay = 100,
		},
		on_attach = function(buffer)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, desc)
				vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
			end

			map("n", "<leader>ghP", gs.preview_hunk, "[G]it [H]unk [P]review")
			map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "[G]it [H]unk [S]tage")
			map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "[G]it [H]unk [R]eset")
			map("n", "<leader>gbs", gs.stage_buffer, "[G]it [B]uffer [S]tage")
			map("n", "<leader>gbr", gs.reset_buffer, "[G]it [B]uffer [R]eset")
			map("n", "<leader>gB", function()
				gs.blame_line({ full = true })
			end, "[G]it [B]lame Line")
			map("n", "<leader>gt", function()
				gs.toggle_deleted()
				gs.toggle_word_diff()
			end, "[G]it [T]oggle Deleted")

			-- Quickfix
			map("n", "<leader>lg", gs.setqflist, "[L]ist [G]it Hunks")
			map("n", "<leader>lG", function()
				gs.setqflist("all")
			end, "[L]ist [G]it All Hunks")

			-- Text Object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
		end,
	},
}
