return {
    setup = function()
        require('overseer').setup({
            templates = { "builtin"},
            task_list = {
                separator = '',
            },
        })
        vim.cmd[[highlight OverseerTaskBorder guibg=NONE]]
        vim.cmd[[highlight OverseerTask guibg=NONE]]
        vim.cmd[[highlight OverseerOutput guibg=NONE]]
        require('config.overseer.templates').setup()
    end
}
