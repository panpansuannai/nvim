local opts = { noremap = true, silent = true }
return {
    setup = function()
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
    end
}
