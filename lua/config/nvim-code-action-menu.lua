return {
    setup = function() 
        vim.keymap.set("n", "<leader>la", "<cmd>CodeActionMenu<cr>", {unique=true})
    end
}
