return {
    setup = function()
        vim.keymap.set('n', '<leader><leader>w', '<cmd>HopWordAC<cr>', {unique = true})
        vim.keymap.set('n', '<leader><leader>b', '<cmd>HopWordBC<cr>', {unique = true})
        vim.keymap.set('n', '<leader><leader>j', '<cmd>HopLineStartAC<cr>', {unique = true})
        vim.keymap.set('n', '<leader><leader>k', '<cmd>HopLineStartBC<cr>', {unique = true})
    end
}
