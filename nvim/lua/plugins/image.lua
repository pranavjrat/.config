return {
  {
    "edluffy/hologram.nvim",
    event = "VeryLazy",
    config = function()
      require("hologram").setup({
        auto_display = true  -- automatically display images when cursor is over links
      })
    end
  },
  -- Uncomment this alternative if you prefer image.nvim instead
  -- {
  --   "samodostal/image.nvim",
  --   event = "VeryLazy",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim"
  --   },
  --   config = function()
  --     require("image").setup({
  --       render = {
  --         min_padding = 5,
  --         show_label = true,
  --         use_dither = true,
  --         foreground_color = false,
  --         background_color = false
  --       },
  --       events = {
  --         update_on_nvim_resize = true,
  --       },
  --     })
  --   end
  -- }
}
