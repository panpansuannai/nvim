return {
    keymap = function()
        vim.keymap.set('n', '<leader>oo', "<cmd>OverseerRun<cr>")
        vim.keymap.set('n', '<leader>op', "<cmd>OverseerToggle bottom<cr>")
        vim.keymap.set('n', '<leader>on', "<cmd>OverseerBuild<cr>")
    end
}
