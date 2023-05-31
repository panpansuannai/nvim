table.insert(vim.custom.keymap_modules, {
    setup = function()
        vim.keymap.set('n', '<leader>G', '<cmd>LazyGit<cr>', { unique = true })
    end
})
