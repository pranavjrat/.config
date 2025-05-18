return {
  "github/copilot.vim",
  lazy = false,
  config = function()
    -- Basic configuration
    vim.g.copilot_enabled = true
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    
    -- Enable Copilot with <leader>co in normal mode
    vim.keymap.set('n', '<leader>co', ':Copilot enable<CR>', { noremap = true, silent = true })
    
    -- Disable Copilot with <leader>cd in normal mode
    vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { noremap = true, silent = true })
    
    -- Accept suggestion with Ctrl-Y in insert mode
    vim.cmd[[imap <silent><script><expr> <C-I> copilot#Accept("\<CR>")]]
    
    -- Optional: See next suggestion with Alt-] in insert mode
    vim.cmd[[imap <silent> <M-]> <Plug>(copilot-next)]]
    -- Optional: See previous suggestion with Alt-[ in insert mode
    vim.cmd[[imap <silent> <M-[> <Plug>(copilot-previous)]]
    -- Optional: Manually request suggestion with Ctrl-Space
    vim.cmd[[imap <silent> <C-Space> <Plug>(copilot-suggest)]]
  end,
}
