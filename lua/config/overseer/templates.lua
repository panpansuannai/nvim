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
                local args = {
                    "test",
                    "-v",
                    "-gcflags",
                    "all=-l -N",
                    package
                }
                if #params.coverprofile > 0 then
                    table.insert(args, "-coverprofile")
                    table.insert(args, params.coverprofile)
                end
                return {
                    cmd = {
                        "go"
                    },
                    args = args,
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
                },
                coverprofile = {
                    type = "string",
                    name = "test coverage file",
                    desc = "test coverage file",
                    optional = true,
                    default = "",
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
                local args = {
                    "test",
                    "-v",
                    "-gcflags",
                    "all=-l -N",
                    vim.fn.expand('%:p:h'),
                    "-run",
                    vim.fn.expand('<cword>')
                }
                if #params.coverprofile > 0 then
                    table.insert(args, "-coverprofile")
                    table.insert(args, params.coverprofile)
                end
                return {
                    cmd = {
                        "go"
                    },
                    args = args,
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
                },
                coverprofile = {
                    type = "string",
                    name = "test coverage file",
                    desc = "test coverage file",
                    optional = true,
                    default = "",
                }
            },
            components = {
                "on_complete_notify"
            },
        })
        overseer.register_template({
            name = "[Golang] Build current directory",
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
                        "build",
                        "-o",
                        params.output,
                        vim.fn.expand('%:p:h'),
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
                },
                output = {
                    type = "string",
                    name = "output",
                    desc = "output",
                    optional = false,
                }
            },
            components = {
                "on_complete_notify"
            },
        })
        overseer.register_template({
            name = "[Golang] Build DMP",
            builder = function(params)
                return {
                    cmd = {
                        "go"
                    },
                    args = {
                        "build",
                        "-gcflags",
                        "all=-l -N",
                        "-o",
                        params.output,
                        "./cmd"
                    },
                }
            end,
            params = {
                output = {
                    type = "string",
                    name = "output",
                    desc = "output",
                    optional = false,
                    default = "output/people.payroll.dmp",
                }
            },
            components = {
                "on_complete_notify"
            },
        })
    end
}
