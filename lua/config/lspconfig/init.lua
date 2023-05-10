-- Diagnostic
vim.cmd [[sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=]]
vim.cmd [[sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=]]
vim.cmd [[sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=]]
vim.cmd [[sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=]]

vim.diagnostic.config({
    float = {},
    update_in_insert = true,
    virtual_text = {
        prefix = '',
        source = false,
    }
})

-- Demo
--[[
function my_hover_handler(_, result, ctx, config)
    if result ~= nil and result.contents ~= nil then
        -- vim.notify(result.contents, vim.lsp.log_levels.INFO)
        vim.notify('', vim.lsp.log_levels.INFO, {
            title = "Hover",
            render = function(bufnr, record, hl, config)
                local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
                vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, markdown_lines)
            end
        })
    end
end

local old_hover_handler = vim.lsp.handlers['textDocument/hover']
if old_hover_handler == nil then
    vim.lsp.handlers['textDocument/hover'] = my_hover_handler()
else
    vim.lsp.handlers['textDocument/hover'] = function(...)
        my_hover_handler(...)
        old_hover_handler(...)
    end
end
]]
--

local on_attach = function(client, bufnr)
    -- Format on save.
    vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
            vim.lsp.buf.format { async = true }
        end
    })
    vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
        buffer = bufnr,
        callback = function(ev)
            local pos = vim.lsp.util.make_position_params()
            vim.lsp.buf_request(bufnr, 'textDocument/hover', pos, function(_, result, ctx, config)
                if result ~= nil and result.contents ~= nil then
                    if vim.lsp.util.make_position_params().position.line ~= pos.position.line then
                        return
                    end
                    vim.notify("", vim.lsp.log_levels.INFO, {
                        title = 'Hover',
                        onopen = function(win)
                            vim.api.nvim_win_set_option(win, 'wrap', true)
                        end,
                        render = function(buf, record)
                            local md_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
                            vim.api.nvim_buf_set_lines(buf, 0, -1, false, md_lines)
                            vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
                        end
                    })
                end
            end)
        end
    })
end

-- language servier configs
require 'lspconfig'.gopls.setup {
    single_file_support = true,
    on_attach = on_attach,
}

-- example to setup lua_ls and enable call snippets
require 'lspconfig'.lua_ls.setup({
    settings = {
        Lua = {
            completion = {
                callSnippet = "Replace"
            }
        }
    }
})
-- require('go').setup()
-- require 'lspconfig'.clangd.setup {}
