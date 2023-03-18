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
          NoiceCmdlinePrompt= {  bg = "love" },
          NoiceCmdlinePopupBorder = { fg = "love" },
          NoiceCursor = { bg = "highlight_med" },
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
      { "<leader>tl", "<cmd>TodoTrouble<cr>",   desc = "[T]odo [L]ist" },
      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "[F]ind [T]odos" },
    },
  },

}
