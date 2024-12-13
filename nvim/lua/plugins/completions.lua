return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        --sources for completion
        sources = cmp.config.sources({
          { name = "luasnip" }, -- For luasnip users.
          { name = "nvim_lsp" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
  --friendly-snippets
  {
    "rafamadriz/friendly-snippets",    -- Predefined snippets (including React)
    lazy = true,                       -- Optional, you can set it to false if you want it loaded immediately
    dependencies = "L3MON4D3/LuaSnip", -- Ensure LuaSnip is loaded before snippets
  },
  --python
  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    config = function()
      require("luasnip.loaders.from_lua").load({ paths = "./snippets" })
    end
  },

}
