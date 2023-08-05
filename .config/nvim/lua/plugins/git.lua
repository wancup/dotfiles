return {
  -- Signs
  {
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

        map("n", "<leader>ghn", gs.next_hunk, "[G]it [H]unk [N]ext")
        map("n", "<leader>ghp", gs.prev_hunk, "[G]it [H]unk [P]rev")
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

        -- Text Object
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
      end,
    },
  },

  -- Lazygit
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitCurrentFile", "LazyGitConfig", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "[L]azy [G]it" },
    },
  },

  -- Diff View
  {
    "sindrets/diffview.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "[G]it [D]iff" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "[G]it Diff [C]lose" },
      { "<leader>gl", "<cmd>DiffviewFileHistory %<cr>", desc = "[G]it [L]og Current File" },
      { "<leader>gL", "<cmd>DiffviewFileHistory<cr>", desc = "[G]it [L]og" },
    },
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        keymaps = {
          view = {
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
          },
          file_panel = {
            { "n", "<C-j>", actions.select_entry, { desc = "Open the diff for the selected entry." } },
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
          },
          file_history_panel = {
            { "n", "<C-j>", actions.select_entry, { desc = "Open the diff for the selected entry." } },
            { "n", "q", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" } },
          },
        },
      })
    end,
  },

  -- Messenger
  {
    "rhysd/git-messenger.vim",
    keys = {
      { "<leader>gm", "<cmd>GitMessenger<cr>", desc = "[G]it [M]essenger" },
    },
  },
}
