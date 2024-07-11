return {
    keymap = function()
        vim.keymap.set('n', '<leader>oo', "<cmd>OverseerRun<cr>")
        vim.keymap.set('n', '<leader>op', "<cmd>OverseerToggle bottom<cr>")
        vim.keymap.set('n', '<leader>on', "<cmd>OverseerBuild<cr>")

        -- create mr
        vim.keymap.set('n', '<leader>or', function()
            local repo = vim.fn.system([[git remote show -n origin | grep -m 1 -o "\w*/\w*.git"]])
            if #repo < 5 then
                repo = ""
            else
                repo = string.sub(repo, 1, -6)
            end
            local branch = vim.fn.system('git branch --show-current')
            if branch ~= nil then
                branch = string.gsub(branch, '\n', '')
            end
            local title = vim.fn.system('git log -1 --pretty=%B')
            if title ~= nil then
                title = string.gsub(title, '\n', '')
            end
            local overseer = require('overseer.form')
            overseer.open("*Create merge request", {
                Repository = {
                    type = "string",
                    order = 1,
                    default = repo,
                },
                Title = {
                    type = "string",
                    order = 2,
                    default = title,
                },
                Desc = {
                    type = "string",
                    order = 3,
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
                    default = "yes",
                },
            }, {}, function(params)
                if params == nil then
                    return
                end
                --[[
                local ffi = require('ffi')
                local param = ffi.new('mr_param',
                    ffi.new('char[?]', #params.Repository + 1, params.Repository),
                    ffi.new('char[?]', #params.Source + 1, params.Source),
                    ffi.new('char[?]', #params.Target + 1, params.Target),
                    ffi.new('char[?]', #params.Title + 1, params.Title)
                )
                if params.RemoveSource == "yes" then
                    param.remove_source = 1
                end
                vim.oxi.create_mr(param)
                    ]]
                vim.fn.CreateMR({
                    project = params.Repository,
                    title = params.Title,
                    desc = "",
                    source = params.Source,
                    target = params.Target,
                })
            end)
        end)

        -- golang staticcheck
        vim.keymap.set('n', '<leader>os', function()
            local filename = vim.api.nvim_buf_get_name(0)
            local bufid = vim.api.nvim_get_current_buf()
            local pkg = vim.fn.expand('%:p:h')
            local overseer = require('overseer.form')
            overseer.open("*[Golang] staticcheck", {
                Filename = {
                    type = "string",
                    order = 1,
                    default = filename,
                },
                Package = {
                    type = "string",
                    order = 2,
                    default = pkg,
                },
            }, {}, function(params)
                if params == nil then
                    return
                end
                local ffi = require('ffi')
                local p = ffi.new('golang_check_param',
                    ffi.new('char[?]', #"oxi_check" + 1, "oxi_check"),
                    ffi.new('char[?]', #params.Filename + 1, params.Filename),
                    ffi.new('char[?]', #params.Package + 1, params.Package)
                )
                local group = vim.api.nvim_create_augroup("staticcheck", {})
                if #vim.api.nvim_get_autocmds({ group = group, buffer = bufid }) == 0 then
                    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                        group = group,
                        buffer = bufid,
                        callback = function()
                            local ffi = require('ffi')
                            local p = ffi.new('golang_check_param',
                                ffi.new('char[?]', #"oxi_check" + 1, "oxi_check"),
                                ffi.new('char[?]', #params.Filename + 1, params.Filename),
                                ffi.new('char[?]', #params.Package + 1, params.Package)
                            )
                            vim.oxi.go_static_check(p)
                        end,
                    })
                end
                vim.oxi.go_static_check(p)
            end)
        end)
    end
}
