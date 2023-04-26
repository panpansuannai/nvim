module = {}
module.key = ''

function module.setup()
    vim.cmd([[
        autocmd WinLeave * :lua require('utils.win_auto_close').try()
        ]])
end

function module.mark()
    vim.w[module.key] = true
end

function module.cancel()
    vim.w[module.key] = nil
end

function module.try() 
    if vim.w[module.key] != nil then
        
    end
end
return module
