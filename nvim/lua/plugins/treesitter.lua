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
        ensure_installed = { "lua_ls", "ts_ls", "pyright" }, -- Added pyright for Python
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

      -- TypeScript
      lspconfig.ts_ls.setup({
        capabilities = capabilities
      })

      -- HTML
      lspconfig.html.setup({
        capabilities = capabilities
      })

      -- Clangd
      lspconfig.clangd.setup({
        capabilities = capabilities
      })

      -- Lua
      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })

      -- TailwindCSS
      lspconfig.tailwindcss.setup({
        capabilities = capabilities
      })

      -- CSS
      lspconfig.cssls.setup({
        capabilities = capabilities
      })

      -- ESLint
      lspconfig.eslint.setup({
        capabilities = capabilities
      })

      -- JSON
      lspconfig.jsonls.setup({
        capabilities = capabilities
      })

      -- Python
      lspconfig.pyright.setup({ -- Configuration for Python
        capabilities = capabilities
      })

      -- Emmet
      lspconfig.emmet_language_server.setup({
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

      -- Keymaps
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
  {
    "olrtg/nvim-emmet",
    config = function()
      vim.keymap.set({ "n", "v" }, '<leader>xe', require('nvim-emmet').wrap_with_abbreviation)
    end,
  },
}

