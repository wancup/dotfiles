return {
  -- LSP
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "Format" },
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      { "folke/neodev.nvim",       config = true },
    },
    keys = {
      { "<leader>F",  "<cmd>Format<cr>",                         desc = "[F]ormat" },

      -- Diagnostic
      { "<leader>dl", vim.diagnostic.open_float,                 desc = "[D]iagnostics [L]ine" },
      { "<leader>dn", vim.diagnostic.goto_next,                  desc = "[D]iagnostic [N]ext" },
      { "<leader>dp", vim.diagnostic.goto_prev,                  desc = "[D]iagnostic [P]rev" },

      -- Goto
      { "gd",         "<cmd>Telescope lsp_definitions<cr>",      desc = "[G]oto [D]efinition", },
      { "gr",         "<cmd>Telescope lsp_references<cr>",       desc = "[G]oto [R]eferences" },
      { "gD",         vim.lsp.buf.declaration,                   desc = "[G]oto [D]eclaration" },
      { "gI",         "<cmd>Telescope lsp_implementations<cr>",  desc = "[G]oto [I]mplementations" },
      { "gt",         "<cmd>Telescope lsp_type_definitions<cr>", desc = "[G]oto [T]ype Definitions" },
      { "K",          vim.lsp.buf.hover,                         desc = "Hover" },
      { "gK",         vim.lsp.buf.signature_help,                desc = "Signature Help", },

      -- Code Action
      { "<leader>a",  vim.lsp.buf.code_action,                   desc = "Code [A]ction",            mode = { "n", "v" }, },
    },
    config = function()
      vim.diagnostic.config({ underline = true, severity_sort = true })

      local on_attach = function(_, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
          vim.lsp.buf.format()
        end, {})
      end

      local default_capabilities = vim.lsp.protocol.make_client_capabilities()
      local capabilities = require("cmp_nvim_lsp").default_capabilities(default_capabilities)

      require("mason-lspconfig").setup()
      require("mason-lspconfig").setup_handlers({
        function(server)
          require("lspconfig")[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        end
      })
    end,
  },

  -- Linter and Formatter
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = function()
      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end

      local nls = require("null-ls")
      return {
        on_attach = on_attach,
        sources = {
          nls.builtins.formatting.shfmt,
        },
      }
    end,
  },

}
