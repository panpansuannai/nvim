table.insert(vim.custom.keymap_modules, {
    setup = function()
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
            require('telescope.builtin').lsp_references({
                show_line = false,
            })
        end, { unique = true })
        vim.keymap.set('n', 'gi', function() require('telescope.builtin').lsp_implementations() end, { unique = true })
        vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end, { unique = true })
        vim.keymap.set('n', 'gD', function()
            utils.copy_current_tab()
            require('telescope.builtin').lsp_definitions()
        end, { unique = true })
        vim.keymap.set('n', 'gt', function() require('telescope.builtin').lsp_type_definitions() end, { unique = true })
        vim.keymap.set('n', 'gT', function()
            require('telescope.builtin').lsp_type_definitions({
                jump_type = "tab"
            })
        end, { unique = true })
        vim.keymap.set('n', '<leader>ts', function() require('telescope.builtin').lsp_document_symbols() end,
            { unique = true })
        vim.keymap.set('n', '<leader>tw', function() require('telescope.builtin').lsp_workspace_symbols() end,
            { unique = true })

        -- Diagnostic
        vim.keymap.set('n', '<leader>db', function()
            require('telescope.builtin').diagnostics({
                bufnr = 0
            })
        end, { unique = true })
        vim.keymap.set('n', '<leader>dw', function()
            require('telescope.builtin').diagnostics({
                bufnr = nil
            })
        end, { unique = true })
    end
})
