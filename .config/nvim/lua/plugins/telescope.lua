return {
  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim", "olacin/telescope-gitmoji.nvim" },
    cmd = "Telescope",
    keys = {
      { "<leader><space>", "<cmd>Telescope live_grep<cr>",                 desc = "Live Grep" },
      { "<leader>fb",      "<cmd>Telescope buffers<cr>",                   desc = "[F]ind [B]uffers" },
      { "<leader>ff",      "<cmd>Telescope find_files<cr>",                desc = "[F]ind [F]iles" },
      { "<leader>fr",      "<cmd>Telescope oldfiles<cr>",                  desc = "[F]ind [R]ecent Files" },
      { "<leader>fR",      "<cmd>Telescope resume<cr>",                    desc = "[F]ind [R]esume" },
      { "<leader>fa",      "<cmd>Telescope autocommands<cr>",              desc = "[F]ind [A]utoCommands" },
      { "<leader>fB",      "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "[F]ind Current [B]uffer" },
      { "<leader>fc",      "<cmd>Telescope commands<cr>",                  desc = "[F]ind [C]ommands" },
      { "<leader>fC",      "<cmd>Telescope command_history<cr>",           desc = "[F]ind [C]ommand History" },
      { "<leader>fd",      "<cmd>Telescope diagnostics<cr>",               desc = "[F]ind [D]iagnostics" },
      { "<leader>fh",      "<cmd>Telescope highlights<cr>",                desc = "[F]ind [H]ighlights" },
      { "<leader>fk",      "<cmd>Telescope keymaps<cr>",                   desc = "[F]ind [K]eymaps" },
      { "<leader>fvo",     "<cmd>Telescope vim_options<cr>",               desc = "[F]ind [V]im [O]ptions" },
      { "<leader>fw",      "<cmd>Telescope grep_string<cr>",               desc = "[F]ind [W]ord" },
      { "<leader>fs",      "<cmd>Telescope lsp_document_symbols<cr>",      desc = "[F]ind [S]ymbols", },
      { "<leader>fS",      "<cmd>Telescope lsp_workspace_symbols<cr>",     desc = "[F]ind Workspace [S]ymbols", },

      -- git
      { "<leader>fgl",     "<cmd>Telescope git_commits<cr>",               desc = "[F]ind [G]it [L]og" },
      { "<leader>fgh",     "<cmd>Telescope git_bcommits<cr>",              desc = "[F]ind [G]it [H]istory" },
      { "<leader>fgb",     "<cmd>Telescope git_branches<cr>",              desc = "[F]ind [G]it [B]ranches" },
      { "<leader>fgs",     "<cmd>Telescope git_status<cr>",                desc = "[F]ind [G]it [S]tatus" },
      { "<leader>fgS",     "<cmd>Telescope git_stash<cr>",                 desc = "[F]ind [G]it [S]tash" },
      { "<leader>fgS",     "<cmd>Telescope git_stash<cr>",                 desc = "[F]ind [G]it [S]tash" },
      { "<leader>fgm",     "<cmd>Telescope gitmoji<cr>",                   desc = "[F]ind [G]it[M]oji" },
    },
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-i>"] = "which_key",
            ["<C-j>"] = "select_default",
          },
          n = {
            ["q"] = "close",
          },
        },
        layout_strategy = "vertical",
      },
      extensions = {
        gitmoji = {
          action = function(entry)
            local emoji = entry.value.value
            vim.fn.setreg(vim.v.register, emoji)
          end,
        },
      },
    },
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)
      telescope.load_extension("gitmoji")
    end
  }
}