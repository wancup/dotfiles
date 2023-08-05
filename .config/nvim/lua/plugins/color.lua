return {
  -- Colorscheme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        dim_nc_background = true,
        disable_italics = true,
        highlight_groups = {
          -- Treesitteer
          Keyword = { fg = "#7c9cee" }, -- Overwrap to increase contrast
          -- Noice
          NoiceCmdlinePopupBorder = { fg = "love" },
          NoiceCursor = { bg = "highlight_med" },
          -- Illuminate
          IlluminatedWordText = { bg = "love", blend = 20 },
          IlluminatedWordRead = { bg = "love", blend = 20 },
          IlluminatedWordWrite = { bg = "love", blend = 20 },
          -- Node.js Package Info
          PackageInfoOutdatedVersion = { fg = "love" },
          PackageInfoUpToDateVersion = { fg = "highlight_med" },
        },
      })
      vim.cmd("colorscheme rose-pine")
    end,
  },

  -- TODO comment
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = { "BufReadPost", "BufNewFile" },
    config = true,
    keys = {
      { "<leader>tL", "<cmd>TodoTrouble<cr>", desc = "[T]odo [L]ist" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "[F]ind [T]odos" },
    },
  },

  -- Cursor Word Highlight
  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      min_count_to_highlight = 2,
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },

  -- Tailspace
  {
    "echasnovski/mini.trailspace",
    version = "*",
    event = { "BufReadPost" },
    config = true,
  },
}
