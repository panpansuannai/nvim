return {
    setup = function()
        local group = vim.api.nvim_create_augroup("panpan", {})
        vim.api.nvim_create_autocmd({ "CursorHold" }, {
            group = group,
            pattern = { "*.go" },
            callback = function()
                local node = vim.treesitter.get_node()
                if string.match(node:type(), "identifier") then
                    vim.lsp.buf.hover()
                end
            end,
        })
    end
}
