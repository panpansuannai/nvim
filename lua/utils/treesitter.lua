return {
    find_nearest_parent = function(node, types)
        while node ~= nil do
            if vim.tbl_contains(types, node:type()) then
                break
            end
            node = node:parent()
        end
        return node
    end
}
