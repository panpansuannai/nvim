return {
    find_nearest_parent = function(node, types)
        while node ~= nil do
            if vim.tbl_contains(types, node:type()) then
                break
            end
            node = node:parent()
        end
        return node
    end,
    iter_func = function(fn)
        local root = vim.treesitter.get_node():tree():root()
        local query = vim.treesitter.query.parse('go', [[
        ([(method_declaration name:(field_identifier) @mname)
        (function_declaration name:(identifier) @fname)])
    ]])
        for id, node, _ in query:iter_captures(root, 0) do
            fn(node)
        end
    end
}
