return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

        map("n", "<leader>ghn", gs.next_hunk, "[G]it [H]unk [N]ext")
        map("n", "<leader>ghp", gs.prev_hunk, "[G]it [H]unk [P]rev")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "[G]it [H]unk [S]tage")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "[G]it [H]unk [R]eset")
        map("n", "<leader>gbs", gs.stage_buffer, "[G]it [B]uffer [S]tage")
        map("n", "<leader>gbr", gs.reset_buffer, "[G]it [B]uffer [R]eset")
        map("n", "<leader>ghp", gs.preview_hunk, "[G]it [H]unk [P]review")
        map("n", "<leader>gB", function() gs.blame_line({ full = true }) end, "[G]it [B]lame Line")
        map("n", "<leader>gd", gs.diffthis, "[G]it [D]iff This")
        map("n", "<leader>gD", function() gs.diffthis("~") end, "[G]it [D]iff This ~")
      end,
    },
  }
}
