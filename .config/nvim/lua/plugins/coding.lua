return {
  -- Toggle Comment
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    keys = {
      { "<leader>/", "<Plug>(comment_toggle_linewise_current)", mode = { "n" }, desc = "Toggle Comment" },
      {
        "<leader>/",
        "<Plug>(comment_toggle_linewise_visual)",
        mode = { "x" },
        desc = "Toggle Selected Comment",
      },
    },
    opts = {
      mappings = false,
      pre_hook = function(...)
        local ok, ts_context = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
        if ok then
          return ts_context.create_pre_hook()(...)
        end
      end,
    },
  },

  -- Better Rename/Replace
  {
    "filipdutescu/renamer.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>rn", "<cmd>lua require('renamer').rename()<cr>", desc = "[R]e[N]ame" },
    },
    config = function()
      local mappings_utils = require("renamer.mappings.utils")
      require("renamer").setup({
        mappings = {
          ["<c-i>"] = nil,
          ["<c-a>"] = mappings_utils.set_cursor_to_start,
          ["<c-e>"] = mappings_utils.set_cursor_to_end,
          ["<c-b>"] = nil,
          ["<c-c>"] = function()
            vim.api.nvim_input("<esc>")
          end,
          ["<c-u>"] = mappings_utils.clear_line,
          ["<c-r>"] = nil,
        },
      })
    end,
  },
  {
    "roobert/search-replace.nvim",
    keys = {
      { "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", desc = "[R]eplace[S]ection" },
      { "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>", desc = "[R]eplace[O]pen" },
      { "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", desc = "[R]eplace[W]ord" },
      { "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", desc = "[R]eplace[W]ORD" },
      { "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", desc = "[R]eplace[E]xpr" },
      { "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>", desc = "[R]eplace[F]ile" },

      { "<leader>rbs", "<CMD>SearchReplaceMultiBufferSelections<CR>", desc = "[R]eplaceMulti[B]uffer[S]ection" },
      { "<leader>rbo", "<CMD>SearchReplaceMultiBufferOpen<CR>", desc = "[R]eplaceMulti[B]uffer[O]pen" },
      { "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWord<CR>", desc = "[R]eplaceMulti[B]uffer[W]ord" },
      { "<leader>rbW", "<CMD>SearchReplaceMultiBufferCWORD<CR>", desc = "[R]eplaceMulti[B]uffer[W]ORD" },
      { "<leader>rbe", "<CMD>SearchReplaceMultiBufferCExpr<CR>", desc = "[R]eplaceMulti[B]uffer[E]xpr" },
      { "<leader>rbf", "<CMD>SearchReplaceMultiBufferCFile<CR>", desc = "[R]eplaceMulti[B]uffer[F]ile" },
    },
    config = true,
  },

  -- Auto Close Brackets
  {
    "echasnovski/mini.pairs",
    version = "*",
    event = "InsertEnter",
    config = true,
  },

  -- Session
  {
    "olimorris/persisted.nvim",
    event = { "VeryLazy" },
    keys = {
      { "<leader>St", "<cmd>SessionToggle<cr>", desc = "[S]ession [T]oggle" },
      { "<leader>Ss", "<cmd>SessionSave<cr>", desc = "[S]ession [S]ave" },
      { "<leader>Sl", "<cmd>SessionLoad<cr>", desc = "[S]ession [L]oad" },
    },
    opts = {
      should_autosave = function()
        local filetype = vim.bo.filetype
        if filetype == "alpha" or filetype == "lazy" then
          return false
        end
        return true
      end,
    },
  },

  -- Node.js Packages
  {
    "vuki656/package-info.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    ft = "json",
    opts = {
      package_manager = "pnpm",
    },
    keys = {
      { "<leader>Nt", "<cmd>lua require('package-info').toggle()<cr>", desc = "[N]ode.js [T]oggle Info" },
      { "<leader>Na", "<cmd>lua require('package-info').install()<cr>", desc = "[N]ode.js [A]dd Package" },
      { "<leader>Nd", "<cmd>lua require('package-info').delete()<cr>", desc = "[N]ode.js [D]elete Package" },
      {
        "<leader>Nc",
        "<cmd>lua require('package-info').change_version()<cr>",
        desc = "[N]ode.js [C]hange Package Version",
      },
    },
  },

  -- Easy Jump
  {
    "ggandor/leap.nvim",
    keys = { "S", "s" },
    config = function()
      local leap = require("leap")
      leap.add_default_mappings()
      leap.opts.highlight_unlabeled_phase_one_targets = true
      vim.api.nvim_set_hl(0, "LeapBackdrop", { link = "Comment" })
    end,
  },
  {
    "jinh0/eyeliner.nvim",
    keys = { "f", "F" },
    config = function()
      require("eyeliner").setup({
        highlight_on_key = true,
        dim = true,
      })
      vim.api.nvim_set_hl(0, "EyelinerDimmed", { link = "Comment" })
    end,
  },

  -- Surround
  {
    "echasnovski/mini.surround",
    version = "*",
    event = "VeryLazy",
    opts = {
      mappings = {
        add = "<leader>sa", -- Add surrounding in Normal and Visual modes
        delete = "<leader>sd", -- Delete surrounding
        find = "<leader>sf", -- Find surrounding (to the right)
        find_left = "<leader>sF", -- Find surrounding (to the left)
        highlight = "<leader>sh", -- Highlight surrounding
        replace = "<leader>sr", -- Replace surrounding
        update_n_lines = "<leader>sn", -- Update `n_lines`
      },
    },
  },

  -- Better Increment/Decrement
  {
    "monaqa/dial.nvim",
    keys = {
      { "<C-a>", "<Plug>(dial-increment)", mode = { "n", "v" }, desc = "Increment" },
      { "<C-x>", "<Plug>(dial-decrement)", mode = { "n", "v" }, desc = "Decrement" },
      { "g<C-a>", "g<Plug>(dial-increment)", mode = { "n", "v" }, desc = "Increment" },
      { "g<C-x>", "g<Plug>(dial-decrement)", mode = { "n", "v" }, desc = "Decrement" },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.semver.alias.semver,
          augend.constant.alias.bool,
          augend.constant.new({
            elements = { "&&", "||" },
            word = true,
            cyclic = true,
          }),
          augend.misc.alias.markdown_header,
        },
      })
    end,
  },
}
