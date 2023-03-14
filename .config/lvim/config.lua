--[[
lvim is the global options object

Linters should be
filled in as strings with either
a global executable or a path to
an executable
]]
-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "lunar"

-- 絵文字が半角で表示されるのを防ぐ
vim.fn.setcellwidths({ { 0x2600, 0x27FF, 2 }, { 0x1F000, 0x1FFFF, 2 }, { 0x2B06, 0x2B07, 2 } })

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"

lvim.keys.term_mode["<C-h>"] = false
lvim.keys.term_mode["<C-j>"] = false
lvim.keys.term_mode["<C-k>"] = false
lvim.keys.term_mode["<C-l>"] = false

lvim.keys.normal_mode["<leader><C-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<leader><C-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<S-h>"] = "^"
lvim.keys.normal_mode["<S-j>"] = "}"
lvim.keys.normal_mode["<S-k>"] = "{"
lvim.keys.normal_mode["<S-l>"] = "$"

lvim.keys.visual_mode["<S-h>"] = "^"
lvim.keys.visual_mode["<S-j>"] = "}"
lvim.keys.visual_mode["<S-k>"] = "{"
lvim.keys.visual_mode["<S-l>"] = "$"

lvim.keys.insert_mode["<C-h>"] = "<BS>"
lvim.keys.insert_mode["<C-d>"] = "<Delete>"
lvim.keys.insert_mode["<C-j>"] = "<CR>"
lvim.keys.insert_mode["<C-k>"] = "<C-o>d$"
lvim.keys.insert_mode["<C-a>"] = "<Home>"
lvim.keys.insert_mode["<C-e>"] = "<End>"
lvim.keys.insert_mode["<C-n>"] = "<Down>"
lvim.keys.insert_mode["<C-p>"] = "<Up>"
lvim.keys.insert_mode["<C-f>"] = "<Right>"
lvim.keys.insert_mode["<C-b>"] = "<Left>"

-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.terminal.active = true
lvim.builtin.terminal.insert_mappings = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

local cmp = require "cmp"
lvim.builtin.cmp.mapping["<C-j>"] = cmp.mapping.confirm({ select = false })

local _, telecsope_actions = pcall(require, "telescope.actions")
lvim.builtin.telescope.defaults.mappings.i["<C-j>"] = telecsope_actions.select_default

-- 日本語フォントとNerdFontの衝突を避ける
lvim.builtin.gitsigns.opts.signs.delete.text = "▶︎"

-- ---@usage disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    -- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "prettier",
    ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
    -- filetypes = { "typescript", "typescriptreact" },
  },
}

-- set additional linters
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  {
    -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
    command = "shellcheck",
    ---@usage arguments to pass to the formatter
    -- extra_args = { "--severity", "warning" },
  },
  {
    command = "eslint",
  },
}

-- set code actions
local code_actions = require "lvim.lsp.null-ls.code_actions"
code_actions.setup {
  {
    command = "eslint",
  },
}

-- customize statusline
local components = require("lvim.core.lualine.components")
lvim.builtin.lualine.sections.lualine_a = { components.mode, "mode" }
lvim.builtin.lualine.sections.lualine_y = { components.encoding, components.location }

-- Additional Plugins
lvim.plugins = {
  {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end,
    lazy = true
  },
}

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- avoid to automatic comment out
    vim.opt.formatoptions:remove("r")
    vim.opt.formatoptions:remove("o")
  end
})
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
