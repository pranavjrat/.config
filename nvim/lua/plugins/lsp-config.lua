return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "cssls",
          "emmet_language_server",
          "emmet_ls",
          "eslint",
          "html",
          "jsonls",
          "lua_ls",
          "pyright",
          "tailwindcss",
          "ts_ls",
          "jdtls",
        },
        auto_install = true,
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local default_flags = {
        debounce_text_changes = 300,
        allow_incremental_sync = true,
      }

      -- ts_ls
      vim.lsp.config('ts_ls', {
        capabilities = capabilities,
        flags = default_flags,
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "none",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = false,
              includeInlayVariableTypeHints = false,
              includeInlayPropertyDeclarationTypeHints = false,
              includeInlayFunctionLikeReturnTypeHints = false,
              includeInlayEnumMemberValueHints = false,
            }
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "none",
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = false,
              includeInlayVariableTypeHints = false,
              includeInlayPropertyDeclarationTypeHints = false,
              includeInlayFunctionLikeReturnTypeHints = false,
              includeInlayEnumMemberValueHints = false,
            }
          }
        }
      })

      -- html
      vim.lsp.config('html', {
        capabilities = capabilities,
        flags = default_flags,
      })

      -- clangd
      vim.lsp.config('clangd', {
        capabilities = capabilities,
        flags = default_flags,
        cmd = { "clangd", "--background-index=false", "--clang-tidy=false" }
      })

      -- lua_ls
      vim.lsp.config('lua_ls', {
        capabilities = capabilities,
        flags = default_flags,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
            hint = {
              enable = false,
            },
          }
        }
      })

      -- tailwindcss
      vim.lsp.config('tailwindcss', {
        capabilities = capabilities,
        flags = default_flags,
      })

      -- cssls
      vim.lsp.config('cssls', {
        capabilities = capabilities,
        flags = default_flags,
      })

      -- eslint
      vim.lsp.config('eslint', {
        capabilities = capabilities,
        flags = default_flags,
        settings = {
          workingDirectory = { mode = "auto" },
          codeActionOnSave = {
            enable = false,
          }
        }
      })

      -- jsonls
      vim.lsp.config('jsonls', {
        capabilities = capabilities,
        flags = default_flags,
      })

      -- emmet_language_server
      vim.lsp.config('emmet_language_server', {
        filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "tsx" },
        init_options = {
          includeLanguages = {},
          excludeLanguages = {},
          extensionsPath = {},
          preferences = {},
          showAbbreviationSuggestions = true,
          showExpandedAbbreviation = "always",
          showSuggestionsAsSnippets = false,
          syntaxProfiles = {},
          variables = {},
        },
      })

      -- enable all servers
      vim.lsp.enable({
        'ts_ls',
        'html',
        'clangd',
        'lua_ls',
        'tailwindcss',
        'cssls',
        'eslint',
        'jsonls',
        'emmet_language_server',
      })

      -- diagnostics
      vim.diagnostic.config({
        virtual_text = {
          enabled = true,
          source = "if_many",
          prefix = '●',
          spacing = 2,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'if_many',
          header = '',
          prefix = '',
          max_width = 80,
          max_height = 20,
        },
      })

      -- diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end

      -- keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)
    end,
  },
  {
    "olrtg/nvim-emmet",
    ft = { "html", "css", "javascriptreact", "typescriptreact" },
    config = function()
      local emmet = require("nvim-emmet")
      vim.keymap.set({ "n", "v" }, "<leader>xe", emmet.wrap_with_abbreviation, {
        desc = "Emmet expand",
      })
    end,
  },
}
