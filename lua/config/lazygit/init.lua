return {
    setup = function()
    end,
    keymap = function()
        vim.keymap.set('n', '<leader>G', '<cmd>LazyGit<cr>', { unique = true })
    end
}
