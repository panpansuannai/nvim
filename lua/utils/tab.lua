return {
    copy_current_tab = function()
        local pos = vim.api.nvim_win_get_cursor(0)
        local bufnr = vim.fn.bufnr()
        vim.cmd("tabnew")
        local win = vim.api.nvim_get_current_win()
        vim.api.nvim_win_set_buf(win, bufnr)
        vim.api.nvim_win_set_cursor(win, pos)
    end
}
