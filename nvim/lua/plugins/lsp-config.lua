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
          "cssls",                 -- CSS LSP
          "emmet_language_server", -- Emmet Language Server
          "emmet_ls",              -- Emmet LS
          "eslint",                -- ESLint LSP
          "html",                  -- HTML LSP
          "jsonls",                -- JSON LSP
          "lua_ls",                -- Lua Language Server
          "pyright",               -- Python LSP
          "tailwindcss",           -- TailwindCSS Language Server
          "ts_ls",                 -- TypeScript LSP
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

      local lspconfig = require("lspconfig")
      
      -- Add performance flags for all LSP servers
      local default_flags = {
        debounce_text_changes = 300,
        allow_incremental_sync = true,
      }
      
      lspconfig.ts_ls.setup({
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
      lspconfig.html.setup({
        capabilities = capabilities,
        flags = default_flags,
      })
      lspconfig.clangd.setup({
        capabilities = capabilities,
        flags = default_flags,
        cmd = { "clangd", "--background-index=false", "--clang-tidy=false" }  -- Disable resource-heavy features
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        flags = default_flags,
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,  -- Disable third party checking
            },
            telemetry = {
              enable = false,
            },
            hint = {
              enable = false,  -- Disable hints to save resources
            },
          }
        }
      })
      lspconfig.tailwindcss.setup({
        capabilities = capabilities,
        flags = default_flags,
      })
      lspconfig.cssls.setup {
        capabilities = capabilities,
        flags = default_flags,
      }
      lspconfig.eslint.setup {
        capabilities = capabilities,
        flags = default_flags,
        settings = {
          workingDirectory = { mode = "auto" },
          codeActionOnSave = {
            enable = false,  -- Disable auto-fix on save to reduce CPU
          }
        }
      }
      lspconfig.jsonls.setup {
        capabilities = capabilities,
        flags = default_flags,
      }
      lspconfig.emmet_language_server.setup({
        filetypes = { "css", "eruby", "html", "javascript", "javascriptreact", "less", "sass", "scss", "pug", "typescriptreact", "tsx" },
        -- Read more about this options in the [vscode docs](https://code.visualstudio.com/docs/editor/emmet#_emmet-configuration).
        -- **Note:** only the options listed in the table are supported.
        init_options = {
          ---@type table<string, string>
          includeLanguages = {},
          --- @type string[]
          excludeLanguages = {},
          --- @type string[]
          extensionsPath = {},
          --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/preferences/)
          preferences = {},
          --- @type boolean Defaults to `true`
          showAbbreviationSuggestions = true,
          --- @type "always" | "never" Defaults to `"always"`
          showExpandedAbbreviation = "always",
          --- @type boolean Defaults to `false`
          showSuggestionsAsSnippets = false,
          --- @type table<string, any> [Emmet Docs](https://docs.emmet.io/customization/syntax-profiles/)
          syntaxProfiles = {},
          --- @type table<string, string> [Emmet Docs](https://docs.emmet.io/customization/snippets/#variables)
          variables = {},
        },
      })
      
      -- Configure diagnostics to show by default with performance optimizations
      vim.diagnostic.config({
        virtual_text = {
          enabled = true,
          source = "if_many",  -- Show source only if multiple sources
          prefix = '●',
          spacing = 2,
        },
        signs = true,
        underline = true,
        update_in_insert = false,  -- Don't update diagnostics while typing
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'if_many',
          header = '',
          prefix = '',
          max_width = 80,  -- Limit float width
          max_height = 20,  -- Limit float height
        },
      })
      
      -- Configure diagnostic signs
      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
      end
      
      -- Auto-show diagnostics on cursor hold with throttling
      vim.api.nvim_create_autocmd({ "CursorHold" }, {  -- Removed CursorHoldI to reduce CPU usage
        group = vim.api.nvim_create_augroup("float_diagnostic", { clear = true }),
        callback = function ()
          -- Only show if there are diagnostics on the current line
          local diagnostics = vim.diagnostic.get(0, { lnum = vim.fn.line('.') - 1 })
          if #diagnostics > 0 then
            vim.diagnostic.open_float(nil, {focus=false, scope="line"})
          end
        end
      })
      
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, {})
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {})
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {})
    end,
  },
  {
    "olrtg/nvim-emmet",
    config = function()
      vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
    end,
  },
}
