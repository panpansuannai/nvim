return {
    copy_current_tab = function()
        local pos = vim.api.nvim_win_get_cursor(0)
        local bufnr = vim.fn.bufnr()
        vim.cmd("tabnew")
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, bufnr)
        vim.api.nvim_win_set_cursor(win, pos)
    end,

    setup_tab_close_when_leave = function()
        vim.custom.tab_auto_close = {}
        return vim.api.nvim_create_autocmd({ "TabLeave" }, {
            pattern = { "*" },
            callback = function()
                local tab = vim.api.nvim_get_current_tabpage()
                if vim.custom.tab_auto_close[tab] ~= nil then
                    vim.cmd('tabclose')
                    vim.custom.tab_auto_close[tab] = nil
                end
            end,
        })
    end,

    check_tab_close_when_leave = function()
        return vim.custom.tab_auto_close ~= nil
    end,

    set_tab_close_when_leave = function(tab)
        vim.custom.tab_auto_close[tab] = 1
    end,

    unset_tab_close_when_leave = function(tab)
        vim.custom.tab_auto_close[tab] = nil
    end,

    query_tab_auto_close = function(tab)
        if vim.custom.tab_auto_close ~= nil and vim.custom.tab_auto_close[tab] ~= nil then
            return true
        end
        return false

    end
}
