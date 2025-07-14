return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")
    harpoon:setup({})
    
    -- Add file to harpoon
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end)
    
    -- Toggle harpoon quick menu
    vim.keymap.set("n", "<leader>he", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)
    
    -- Remove current file from harpoon (FIXED)
    vim.keymap.set("n", "<leader>ad", function()
      local list = harpoon:list()
      list:remove()  -- Remove current file (no parameter needed)
    end, { desc = "Remove current file from Harpoon" })
    
    
    -- Select specific harpoon items
    vim.keymap.set("n", "<C-n>", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<C-t>", function()
      harpoon:list():select(2)
    end)
    vim.keymap.set("n", "<C-s>", function()
      harpoon:list():select(3)
    end)
    vim.keymap.set("n", "<C-j>", function()
      harpoon:list():select(4)
    end)
    
    -- Navigate between harpoon items
    vim.keymap.set("n", "<C-S-P>", function()
      harpoon:list():prev()
    end)
    vim.keymap.set("n", "<C-S-N>", function()
      harpoon:list():next()
    end)
    
    -- Telescope integration (FIXED)
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do  -- Fixed: was "*, item" and "harpoon*files"
        table.insert(file_paths, item.value)
      end
      require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
    end
    
    -- Telescope harpoon window (using different key to avoid conflict)
    vim.keymap.set("n", "<C-e>", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open harpoon window with Telescope" })
  end,
}
