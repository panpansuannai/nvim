return {
    setup = function()
        --[[
        vim.api.nvim_create_autocmd({ "CursorHold" }, {
            group = group,
            pattern = { "*.go" },
            callback = function()
                local node = vim.treesitter.get_node()
                if node == nil then
                    return
                end
                if string.match(node:type(), "identifier") then
                    vim.lsp.buf.hover()
                end
            end,
        })]]
    end
}
