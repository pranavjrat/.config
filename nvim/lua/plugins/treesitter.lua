return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require("nvim-treesitter.configs")
      
      configs.setup({
        ensure_installed = {
          "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html",
          "typescript", "python", "java", "kotlin", "scala", "json", "yaml", "xml",
          "css", "scss", "bash", "dockerfile", "gitignore", "markdown", "sql", "groovy"
        },
        sync_install = false,
        highlight = { 
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { 
          enable = true 
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]]"] = "@class.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]["] = "@class.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[["] = "@class.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[]"] = "@class.outer",
            },
          },
        },
      })
      -- Java specific configurations
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = function()
          -- Set Java specific indentation
          vim.opt_local.shiftwidth = 4
          vim.opt_local.tabstop = 4
          vim.opt_local.softtabstop = 4
          vim.opt_local.expandtab = true
          -- Set Java specific text width
          vim.opt_local.textwidth = 120
          vim.opt_local.colorcolumn = "120"
        end,
      })
    end
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
