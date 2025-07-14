return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      -- autostart is enabled by default, no need for autostart = true
      sources = {
        -- Formatters
        null_ls.builtins.formatting.stylua,       -- Lua
        null_ls.builtins.formatting.prettier,     -- JS/TS/HTML/CSS/etc.
        null_ls.builtins.formatting.black,        -- Python (PEP8)
        null_ls.builtins.formatting.isort,        -- Python import sorter
        -- Linters (uncomment if you want)
        -- null_ls.builtins.diagnostics.eslint_d, -- JS/TS linter
      },
    })

    -- Keymap for formatting
    vim.keymap.set("n", "<leader>gf", function()
      vim.lsp.buf.format({ async = true })
    end, { desc = "LSP Format buffer" })
  end,
}

