table.insert(vim.custom.keymap_modules, {
    setup = function()
        vim.keymap.set('n', '<C-g>', function()
            local file_name = vim.fn.expand("%:p")
            vim.notify(file_name, vim.log.levels.INFO, {
                title = "current file:"
            })
        end)
    end
})
