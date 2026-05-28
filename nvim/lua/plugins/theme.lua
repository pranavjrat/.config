return {
  {
    "datsfilipe/vesper.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("vesper")
      vim.api.nvim_set_hl(0, "Normal", { bg = "#252525" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1a1a1a" })

      -- Diagnostics
      vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff5555" })
      vim.api.nvim_set_hl(0, "DiagnosticWarn", { fg = "#ffb86c" })
      vim.api.nvim_set_hl(0, "DiagnosticInfo", { fg = "#8be9fd" })
      vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#50fa7b" })

      -- Underlines in code
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = "#ff5555" })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = "#ffb86c" })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = "#8be9fd" })
      vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = "#50fa7b" })

      -- Virtual text (the inline messages)
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = "#ff5555", bg = "#2d1f1f" })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn", { fg = "#ffb86c", bg = "#2d2416" })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo", { fg = "#8be9fd", bg = "#1a2530" })
      vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#50fa7b", bg = "#1a2b1f" })
    end,
  },
  {
    "yorickpeterse/vim-paper",
    lazy = false,
    priority = 1000,
  },
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    priority = 999,          -- ✅ just below colorscheme priority
    dependencies = {
      "datsfilipe/vesper.nvim", -- ✅ explicit load order
    },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          icons_enabled = true,
          globalstatus = true,
        },
      })
    end,
  },
}
