M = {}

local setup = function()
    if vim.custom == nil then
        vim.custom = {}
    end
    if vim.custom.keymap_modules == nil then
        vim.custom.keymap_modules = {}
    end
end

M.register_module = function(mod)
    setup()
    if mod.keymap == nil then
        vim.notify("register module error")
        return
    end
    table.insert(vim.custom.keymap_modules, mod)
end

M.apply_modules_keymap = function()
    setup()
    for _, v in ipairs(vim.custom.keymap_modules) do
        v.keymap()
    end
    vim.custom.keymap_modules = {}
end

return M

