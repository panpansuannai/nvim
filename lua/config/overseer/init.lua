return {
    setup = function()
        require('overseer').setup({
            strategy = "jobstart",
            templates = { "builtin" },
            task_list = {
                separator = '',
                bindings = {
                    ["<C-l>"] = "",
                    ["<C-h>"] = "",
                    ["L"] = "",
                    ["H"] = "",
                },
            },
            -- Configuration for task floating windows
            task_win = {
                -- How much space to leave around the floating window
                padding = 2,
                border = "rounded",
                -- Set any window options here (e.g. winhighlight)
                win_opts = {
                    winblend = 10,
                },
            },
        })
        vim.cmd [[highlight OverseerTaskBorder guibg=NONE]]
        vim.cmd [[highlight OverseerTask guibg=NONE]]
        vim.cmd [[highlight OverseerOutput guibg=NONE]]
        require('config.overseer.templates').setup()
    end
}
