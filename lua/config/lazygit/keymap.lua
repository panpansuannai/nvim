return {
    setup = function()
        vim.keymap.set('n', '<leader>G', '<cmd>LazyGit<cr>', { unique = true })
    end
}
