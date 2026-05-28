return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "rcasia/neotest-java",
      "nvim-neotest/neotest-jest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-jest")({
            jestCommand = "npx jest",
            jestConfigFile = "jest.config.ts",
          }),
          require("neotest-java")({
            ignore_wrapper = false,
            junit_jar = nil,
          }),
        },
        discovery = {
          enabled = true,
          concurrent = 1,
        },
        running = {
          concurrent = true,
        },
        summary = {
          enabled = true,
          animated = true,
          follow = true,
          expand_errors = true,
        },
        icons = {
          child_indent = "│",
          child_prefix = "├",
          collapsed = "─",
          expanded = "╮",
          failed = "✖",
          final_child_indent = " ",
          final_child_prefix = "╰",
          non_collapsible = "─",
          passed = "✓",
          running = "󰑮",
          running_animated = { "/", "|", "\\", "-", "/", "|", "\\", "-" },
          skipped = "○",
          unknown = "?",
        },
        highlights = {
          adapter_name = "NeotestAdapterName",
          border = "NeotestBorder",
          dir = "NeotestDir",
          expand_marker = "NeotestExpandMarker",
          failed = "NeotestFailed",
          file = "NeotestFile",
          focused = "NeotestFocused",
          indent = "NeotestIndent",
          marked = "NeotestMarked",
          namespace = "NeotestNamespace",
          passed = "NeotestPassed",
          running = "NeotestRunning",
          select_win = "NeotestWinSelect",
          skipped = "NeotestSkipped",
          target = "NeotestTarget",
          test = "NeotestTest",
          unknown = "NeotestUnknown",
        },
      })

      local opts = { noremap = true, silent = true }
      vim.keymap.set("n", "<leader>ttt", function()
        require("neotest").run.run()
      end, opts)
      vim.keymap.set("n", "<leader>tf", function()
        require("neotest").run.run(vim.fn.expand("%"))
      end, opts)
      vim.keymap.set("n", "<leader>td", function()
        require("neotest").run.run({ strategy = "dap" })
      end, opts)
      vim.keymap.set("n", "<leader>ts", function()
        require("neotest").run.stop()
      end, opts)
      vim.keymap.set("n", "<leader>to", function()
        require("neotest").output.open({ enter = true, auto_close = true })
      end, opts)
      vim.keymap.set("n", "<leader>tO", function()
        require("neotest").output_panel.toggle()
      end, opts)
      vim.keymap.set("n", "<leader>tS", function()
        require("neotest").summary.toggle()
      end, opts)
      vim.keymap.set("n", "[t", function()
        require("neotest").jump.prev({ status = "failed" })
      end, opts)
      vim.keymap.set("n", "]t", function()
        require("neotest").jump.next({ status = "failed" })
      end, opts)
    end,
  },
}
