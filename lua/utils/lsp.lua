M = {}
-- @func get_lsp_references
-- @return {
--      range = {
--          end = {
--              line = 1,
--              character = 2,
--          },
--          start = {
--              line = 1,
--              character = 2,
--          },
--      },
--      uri = "file:///..."
-- }
M.get_lsp_references = function(bufnr)
    local pos = vim.lsp.util.make_position_params()
    local result, err = vim.lsp.buf_request_sync(bufnr, "textDocument/references", pos, 1000)
    if err ~= nil then
        vim.notify(err, vim.log.levels.ERROR, {
            title = "get_lsp_references error"
        })
        return nil
    end
    return result
end
return M
