return {
    setup = function()
    end,
    keymap = function()
        vim.keymap.set("n", "<leader>la", "<cmd>CodeActionMenu<cr>", { unique = true })
    end
}
