return {
    setup = function()
        local overseer = require('overseer')
        overseer.register_template({
            name = "[Golang] Test current directory",
            builder = function(params)
                local env = {}
                if params.gomonkey then
                    env.GOARCH = "amd64"
                end
                local package = vim.fn.expand('%:p:h')
                return {
                    cmd = {
                        "go"
                    },
                    args = {
                        "test",
                        "-gcflags=all=-l -N",
                        package
                    },
                    env = env,
                }
            end,
            params = {
                gomonkey = {
                    type = "boolean",
                    name = "run test with gomonkey",
                    desc = "set ENV GOARCH=amd64",
                    optional = false,
                    default = false,
                }
            },
            components = {
                "on_complete_notify"
            },
        })
        overseer.register_template({
            name = "[Golang] Test cursor function",
            builder = function(params)
                local env = {}
                if params.gomonkey then
                    env.GOARCH = "amd64"
                end
                return {
                    cmd = {
                        "go"
                    },
                    args = {
                        "test",
                        "-gcflags=all=-l -N",
                        vim.fn.expand('%:p:h'),
                        "-run",
                        vim.fn.expand('<cword>')
                    },
                    env = env,
                }
            end,
            params = {
                gomonkey = {
                    type = "boolean",
                    name = "run test with gomonkey",
                    desc = "set ENV GOARCH=amd64",
                    optional = false,
                    default = false,
                }
            },
            components = {
                "on_complete_notify"
            },
        })
    end
}
