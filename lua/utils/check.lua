module = {}
function module.checkPlug(s)
    local plug = vim.g["plugs"]
    if plug == nil then
        return false 
    end
    if plug[s] == nil then
        return false
    end
    return true
end
return module
