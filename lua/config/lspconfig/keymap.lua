local function hover_notify(bufnr)
    vim.lsp.buf_request(bufnr, 'textDocument/hover', vim.lsp.util.make_position_params(),
        function(_, result, ctx, config)
            if not (result and result.contents) then
                return
            end
            local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
            markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
            if vim.tbl_isempty(markdown_lines) then
                return
            end
            local cur_win_height = vim.api.nvim_win_get_height(0)
            local cur_win_width = vim.api.nvim_win_get_width(0)
            local buf = vim.api.nvim_create_buf(false, true)
            markdown_lines = vim.lsp.util.stylize_markdown(buf, markdown_lines, config)
            local width, height = vim.lsp.util._make_floating_popup_size(markdown_lines,
                { max_height = math.floor(cur_win_height / 2), max_width = math.floor(cur_win_width / 2) })
            -- local opt      = vim.lsp.util.make_floating_popup_options(height, width, { relative = 'cursor' })
            -- local win      = vim.api.nvim_open_win(buf, false, opt)
            vim.notify("Hover", vim.log.levels.INFO, {
                title = "Hover",
                timeout = 10000,
                on_open = function(winnr)
                    vim.api.nvim_win_set_config(winnr, {
                        height = height,
                        width = width,
                    })
                    vim.api.nvim_win_set_option(winnr, 'wrap', true)
                    vim.api.nvim_win_set_buf(winnr, buf)
                end,
                on_close = function(winnr)
                    vim.api.nvim_buf_delete(buf, { force = true })
                end
            })
            --[[
            local timer    = vim.loop.new_timer()
            timer:start(30000, 0, vim.schedule_wrap(function()
                vim.api.nvim_win_close(win, true)
                vim.api.nvim_buf_delete(buf, { force = true })
            end))
            ]]
            --
        end)
end
return {
    keymap = function()
        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', 'gJ', function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set('n', 'gK', function() vim.diagnostic.goto_prev() end, opts)

        -- Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        vim.keymap.set('n', '<leader>lf',
            '<cmd>lua vim.lsp.buf.format()<CR>', opts)
        vim.keymap.set('n', '<leader>lr',
            '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        vim.keymap.set('n', 'H',
            '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        vim.keymap.set('n', '<leader>ls',
            '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

        vim.keymap.set('n', 'K', function() hover_notify(0) end, { unique = true })
    end
}
