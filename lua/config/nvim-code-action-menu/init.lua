return {
    setup = function()
        table.insert(vim.custom.keymap_modules, {
            setup = function()
                vim.keymap.set("n", "<leader>la", "<cmd>CodeActionMenu<cr>", { unique = true })
            end
        })
    end
}
