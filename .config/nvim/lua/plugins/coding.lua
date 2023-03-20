return {
  -- Toggle Comment
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring", lazy = false },
    keys = {
      { "<leader>/", "<Plug>(comment_toggle_linewise_current)", mode = { "n" }, desc = "Toggle Comment" },
      { "<leader>/", "<Plug>(comment_toggle_linewise_visual)",  mode = { "x" }, desc = "Toggle Selected Comment" }
    },
    opts = {
      mappings = false,
      pre_hook = function(...)
        local ok, ts_context = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
        if ok then
          return ts_context.create_pre_hook()(...)
        end
      end,
    }
  },

  -- Better Rename
  {
    "smjonas/inc-rename.nvim",
    keys = {
      { "<leader>rn", "<cmd>IncRename <cr>", }
    },
    config = function()
      require("inc_rename").setup()
      vim.keymap.set("n", "<leader>rn", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
      end, { expr = true, desc = "[R]e[N]ame" })
    end
  },

  -- Auto Close Brackets
  {
    "windwp/nvim-autopairs",
    dependencies = { "hrsh7th/nvim-cmp" },
    config = function()
      require("nvim-autopairs").setup({ check_ts = true, })
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
    end
  },

  -- Auto Close Tags
  {
    "windwp/nvim-ts-autotag",
    config = true,
  },

  -- Session
  {
    "olimorris/persisted.nvim",
    opts = {
      use_git_branch = true,
      autoload = true,
    },
  },

  -- Node.js Packages
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    opts = {
      package_manager = "pnpm"
    },
    keys = {
      { "<leader>Nt", "<cmd>lua require('package-info').toggle()<cr>",  desc = "[N]ode.js [T]oggle Info" },
      { "<leader>Na", "<cmd>lua require('package-info').install()<cr>", desc = "[N]ode.js [A]dd Package" },
      { "<leader>Nd", "<cmd>lua require('package-info').delete()<cr>",  desc = "[N]ode.js [D]elete Package" },
      {
        "<leader>Nc",
        "<cmd>lua require('package-info').change_version()<cr>",
        desc = "[N]ode.js [C]hange Package Version"
      },
    },
  },
}
