return {
    keymap = function()
        local utils = require('utils.tab')
        vim.keymap.set('n', '<leader>tf', function() require('telescope.builtin').find_files() end, { unique = true })
        vim.keymap.set('n', '<leader>te', function() require('telescope').extensions.recent_files.pick() end,
            { unique = true })
        vim.keymap.set('n', '<leader>tg', function() require('telescope.builtin').live_grep() end, { unique = true })
        vim.keymap.set('n', '<leader>tb', function() require('telescope.builtin').buffers() end, { unique = true })
        vim.keymap.set('n', '<leader>tp', function() require('telescope.builtin').treesitter() end, { unique = true })
        vim.keymap.set('n', '<leader>ty', function() require('telescope.builtin').current_buffer_fuzzy_find() end,
            { unique = true })
        vim.keymap.set('n', '<leader>t', function() require('telescope.builtin').builtin() end, { unique = true })

        -- LSP
        vim.keymap.set('n', '<leader>gi', function() require('telescope.builtin').lsp_incoming_calls() end,
            { unique = true })
        vim.keymap.set('n', '<leader>go', function() require('telescope.builtin').lsp_outgoing_calls() end,
            { unique = true })
        vim.keymap.set('n', 'gr', function()
            require('telescope.builtin').lsp_references({ show_line = false, })
        end, { unique = true })
        vim.keymap.set('n', 'gi', function() require('telescope.builtin').lsp_implementations({ show_line = false }) end,
            { unique = true })
        vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end, { unique = true })
        vim.keymap.set('n', 'gD', function()
            if vim.tbl_count(vim.lsp.get_active_clients({ bufnr = 0 })) == 0 then
                vim.notify("Lsp not ready!", vim.log.levels.WARN, {
                    title = "WARN: go to definitions",
                })
                return
            end
            utils.copy_current_tab()

            local tab = vim.api.nvim_get_current_tabpage()

            require('utils.tab').set_tab_close_when_leave(tab)

            local record = vim.notify("按`M`取消自动关闭该Tab", vim.log.levels.TRACE, {
                title = "通知",
                timeout = 5000,
            })
            vim.t.auto_close_record = record

            --[[
                vim.notify("取消关闭Tab", vim.log.levels.INFO, {
                    title = "Info",
                    timeout = 1000,
                    replace = record,
                })
                --]]
            --[[
            local timer = vim.loop.new_timer()
            if timer ~= nil then
                timer:start(5000, 0, vim.schedule_wrap(function()
                    -- vim.keymap.del('n', 'M', { buffer = buf })
                end))
            end
            --]]
            require('telescope.builtin').lsp_definitions()
        end, { unique = true })
        vim.keymap.set('n', 'gt', function() require('telescope.builtin').lsp_type_definitions() end, { unique = true })
        vim.keymap.set('n', 'gT', function() require('telescope.builtin').lsp_type_definitions({ jump_type = "tab" }) end,
            { unique = true })
        vim.keymap.set('n', '<leader>ts', function() require('telescope.builtin').lsp_document_symbols() end,
            { unique = true })
        vim.keymap.set('n', '<leader>tw', function() require('telescope.builtin').lsp_workspace_symbols() end,
            { unique = true })

        -- Diagnostic
        vim.keymap.set('n', '<leader>db', function()
            require('telescope.builtin').diagnostics({
                show_line = false,
                bufnr = 0
            })
        end, { unique = true })
        vim.keymap.set('n', '<leader>dw', function()
            require('telescope.builtin').diagnostics({
                show_line = false,
                bufnr = nil
            })
        end, { unique = true })
    end
}
