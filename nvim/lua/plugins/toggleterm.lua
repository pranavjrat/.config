return {
    {
        'akinsho/toggleterm.nvim',
        config = function()
            require("toggleterm").setup {
                size=40,
                open_mapping = [[<c-\>]],
                direction = 'vertical',
                shell = vim.o.shell,
            }
        end,
    },
}
