require("remap")
require("set")
--vim.opt.mouse = ""

--remap("<C-d>","<C-d>zz")
--remap("<C-u>","<C-u>zz")

-- Example Lua configuration for copilot.vim
vim.g.copilot_enabled = true        -- Enable Copilot by default
vim.g.copilot_no_tab_map = true     -- Disable the default Tab mapping for Copilot (you can map it yourself)
vim.g.copilot_assume_mapped = true  -- Automatically map the Copilot suggestion key to Tab


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
