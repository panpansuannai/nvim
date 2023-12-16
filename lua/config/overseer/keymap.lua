return {
    keymap = function()
        vim.keymap.set('n', '<leader>oo', "<cmd>OverseerRun<cr>")
        vim.keymap.set('n', '<leader>op', "<cmd>OverseerToggle bottom<cr>")
        vim.keymap.set('n', '<leader>on', "<cmd>OverseerBuild<cr>")

        -- create mr
        vim.keymap.set('n', '<leader>or', function()
            local overseer = require('overseer.form')
            local branch = vim.fn.system('git branch --show-current')
            if branch ~= nil then
                branch = string.gsub(branch, '\n', '')
            end
            local title = vim.fn.system('git log -1 --pretty=%B')
            if title ~= nil then
                title = string.gsub(title, '\n', '')
            end
            overseer.open("*Create merge request", {
                Repository = {
                    type = "string",
                    order = 1,
                    default = "people/payroll_dmp",
                },
                Title = {
                    type = "string",
                    order = 2,
                    default = title,
                },
                Desc = {
                    type = "string",
                    order = 3,
                    -- optional = true,
                    default = "",
                },
                Source = {
                    type = "string",
                    order = 4,
                    default = branch,
                },
                Target = {
                    type = "string",
                    order = 5,
                },
                RemoveSource = {
                    type = "string",
                    order = 6,
                    default = "true",
                },
            }, {}, function(params)
                if params == nil then
                    return
                end
                local ffi = require('ffi')
                local param = ffi.new('create_mr_param',
                    ffi.new('char[?]', #params.Repository+1, params.Repository),
                    ffi.new('char[?]', #params.Source+1, params.Source),
                    ffi.new('char[?]', #params.Target+1, params.Target),
                    ffi.new('char[?]', #params.Title+1, params.Title)
                )
                if params.RemoveSource then
                    param.remove_source = 1
                end
                --[[
                param.project = ffi.new('char[?]', #params.Repository, params.Repository)
                param.source = ffi.new('char[?]', #params.Source, params.Source)
                param.target = ffi.new('char[?]', #params.Target, params.Target)
                param.title = ffi.new('char[?]', #params.Title, params.Title)
                if params.RemoveSource == "true" then
                    param.remove_source = 1
                end
                ]]
                vim.oxi.create_mr(param)
                --[[
                vim.fn.CreateMR(params.Repository, params.Title, params.Desc, params.Source, params.Target,
                    params.RemoveSource)
                    ]]
                -- vim.notify(vim.inspect(params), "info")
            end)
        end)
    end
}
