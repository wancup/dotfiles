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
      "b0o/schemastore.nvim",
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

      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "lua_ls",
          "jsonls",
          "yamlls",
          "html",
          "cssls",
          "tsserver",
          "tailwindcss",
          "astro",
          "rust_analyzer",
        },
      })
      require("mason-lspconfig").setup_handlers({
        function(server)
          require("lspconfig")[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        end
      })

      -- Setup Scheme
      require('lspconfig').jsonls.setup {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas({
              select = {
                "package.json",
                "tsconfig.json",
              }
            }),
            validate = { enable = true },
          },
        },
      }
      require('lspconfig').yamlls.setup {
        settings = {
          yaml = {
            schemas = require('schemastore').yaml.schemas({
              select = {
                "GitHub issue forms",
                "GitHub Issue Template configuration",
                "GitHub Workflow",
                "GitHub Workflow Template Properties",
              },
            }),
          },
        },
      }
    end,
  },

  -- Linter and Formatter
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "jose-elias-alvarez/typescript.nvim",
        config = true,
      },
    },
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

      local null_ls = require("null-ls")
      return {
        on_attach = on_attach,
        sources = {
          null_ls.builtins.formatting.shfmt,
          null_ls.builtins.code_actions.gitsigns,
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.code_actions.eslint,
          null_ls.builtins.formatting.prettier,
          require("typescript.extensions.null-ls.code-actions"),
        },
      }
    end,
  },

  -- Code Action Menu
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
    keys = {
      { "<leader>a", "<cmd>CodeActionMenu<cr>", desc = "Code [A]ction", mode = { "n", "v" }, },
    },
  },

}
