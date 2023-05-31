table.insert(vim.custom.keymap_modules, {
    setup = function()
        vim.keymap.set('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<cr>', { unique = true })
        vim.keymap.set('n', '<leader>gk', '<cmd>Gitsigns prev_hunk<cr>', { unique = true })
        vim.keymap.set('n', '<leader>gj', '<cmd>Gitsigns next_hunk<cr>', { unique = true })
        vim.keymap.set('n', '<leader>gd', '<cmd>Gitsigns diffthis<cr>', { unique = true })
        vim.keymap.set('n', '<leader>gl', '<cmd>Gitsigns setqflist<cr>', { unique = true })
        vim.keymap.set('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { unique = true })
        vim.keymap.set('n', '<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', { unique = true })
        vim.keymap.set('n', '<leader>gS', '<cmd>Gitsigns stage_buffer<cr>', { unique = true })
        vim.keymap.set('n', '<leader>gu', '<cmd>Gitsigns reset_hunk<cr>', { unique = true })
        vim.keymap.set('n', '<leader>g<space>', '<cmd>Gitsigns select_hunk<cr>', { unique = true })
    end
})
