--vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes:1" -- Always show sign column with width of 1
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 300  -- Increased from 50 to reduce CPU usage

vim.opt.colorcolumn = "80"

-- Performance optimizations
vim.opt.lazyredraw = true  -- Don't redraw during macros
vim.opt.synmaxcol = 200    -- Limit syntax highlighting for long lines
vim.opt.timeoutlen = 500   -- Faster timeout for key sequences
vim.opt.ttimeoutlen = 10   -- Faster timeout for escape sequences

