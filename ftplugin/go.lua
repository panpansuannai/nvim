GO = 1
local group = vim.api.nvim_create_augroup("panpan", {})

local function set_diagnostic_on_too_long_line()
    local threshold = 150
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local dnst = {}
    for num, line in pairs(lines) do
        if vim.fn.strchars(line) > threshold then
            table.insert(dnst, {
                severity = 2,
                bufnr = buf,
                lnum = num - 1,
                col = threshold,
                end_col = #line - 1,
                message = "need new line",
            })
        end
    end
    local ns = vim.api.nvim_create_namespace("new_line")
    vim.diagnostic.reset(ns, buf)
    vim.diagnostic.set(ns, buf, dnst, nil)
end


vim.api.nvim_create_autocmd({ "BufWritePre", "BufRead" }, {
    group = group,
    pattern = { "*.go" },
    callback = function()
        set_diagnostic_on_too_long_line()
    end,
})

-- toggle golang spell check
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    group = group,
    pattern = { "*.go" },
    callback = function()
        vim.api.nvim_win_set_option(0, "spell", false)
        vim.api.nvim_buf_set_option(0, "spelllang", "en_us,cjk")
        vim.api.nvim_buf_set_option(0, "spelloptions", "camel")
    end,
})

vim.keymap.set('n', "<leader>zz", function()
    local log_stmt = require('utils.treesitter').find_nearest_parent(vim.treesitter.get_node(),
        { "call_expression" })
    if log_stmt == nil then
        return
    end
    local func_node = log_stmt:child(0)
    if not string.find(vim.treesitter.get_node_text(func_node:child(0), 0), "logger") and
        not string.find(vim.treesitter.get_node_text(func_node:child(1), 0), "logger") then
        return
    end
    local arguments_node = log_stmt:child(1)
    local fmt_node = nil
    local fmt_arg_num = 0
    for node, _ in arguments_node:iter_children() do
        if fmt_node ~= nil then
            fmt_arg_num = fmt_arg_num + 1
        end
        if node:type() == "interpreted_string_literal" then
            fmt_node      = node
            local sibling = fmt_node:next_sibling()
            while sibling ~= nil do
                fmt_arg_num = fmt_arg_num + 1
                sibling = sibling:next_sibling()
            end
            break
        end
    end
    if fmt_node == nil then
        vim.print("not found str")
        return
    end
    local fmt_num = 0
    for _ in string.gmatch(vim.treesitter.get_node_text(fmt_node, 0), "%%%w") do
        fmt_num = fmt_num + 1
    end
    local start_row, start_col, _, end_col = log_stmt:range()
    local ns = vim.api.nvim_create_namespace("golang_fmt")
    vim.print(fmt_num .. "," .. fmt_arg_num)
    if fmt_num ~= fmt_arg_num then
        vim.diagnostic.reset(ns, 0)
        vim.diagnostic.set(ns, 0, { {
            severity = 2,
            bufnr = 0,
            lnum = start_row,
            col = start_col,
            end_col = end_col - 1,
            message = "format arguments number unmatch",
        } })
    end
end)

-- handle error
-- 对于光标下的golang err变量自动生成默认错误处理逻辑
vim.keymap.set('n', "<leader>he", function()
    -- Only support golang.
    local var_decl_node = require('utils.treesitter').find_nearest_parent(vim.treesitter.get_node(),
        { "assignment_statement", "short_var_declaration" })
    if var_decl_node == nil then
        return
    end
    local expr_list_node = var_decl_node:named_child(0)
    local err_var_name = nil
    for node, _ in expr_list_node:iter_children() do
        local name = vim.treesitter.get_node_text(node, 0)
        if string.match(string.lower(name), "err") ~= nil then
            err_var_name = name
            break
        end
    end
    if err_var_name == nil then
        vim.notify("not found variable named like err", vim.log.levels.WARN)
        return
    end
    -- find function call
    local err_func_name = nil
    local err_func_query = vim.treesitter.query.parse('go',
        [[([(call_expression function: (identifier) @name) (selector_expression field: (field_identifier) @name)])]])
    for _, node, _ in err_func_query:iter_captures(var_decl_node, 0) do
        err_func_name = vim.treesitter.get_node_text(node, 0)
        break
    end
    if err_func_name == nil then
        vim.notify("not found function that throw error", vim.log.levels.WARN)
        return
    end
    -- find function
    local function_node = require('utils.treesitter').find_nearest_parent(var_decl_node,
        { "function_declaration", "method_declaration" })
    if function_node == nil then
        vim.notify("not in function", vim.log.levels.WARN)
        return
    end
    local fname = nil
    local is_method = false
    local reciever_type = nil
    local query = vim.treesitter.query.parse('go', [[
        ([(method_declaration name:(field_identifier) @mname)
        (function_declaration name:(identifier) @fname)])
    ]])
    for id, node, _ in query:iter_captures(function_node, 0) do
        fname = vim.treesitter.get_node_text(node, 0, {})
        if query.captures[id] == "mname" then
            is_method = true
        end
        break
    end
    if fname == nil then
        vim.notify("not found function name", vim.log.levels.WARN)
        return
    end
    if is_method then
        -- get reciever type
        local reciever_node = function_node:named_child(0)
        local type_query = vim.treesitter.query.parse('go', [[ ((type_identifier) @type) ]])
        for _, node, _ in type_query:iter_captures(reciever_node, 0) do
            reciever_type = vim.treesitter.get_node_text(node, 0)
        end
    end
    local log_msg = ""
    if is_method and reciever_type ~= nil then
        log_msg = log_msg .. "[" .. reciever_type .. "] "
    end
    log_msg = log_msg .. fname .. " " .. err_func_name .. " err: %v"
    local _, _, row, _ = var_decl_node:range(false)
    vim.api.nvim_buf_set_lines(0, row + 1, row + 1, false, {
        string.format("if %s != nil {", err_var_name),
        string.format([[logger.Error(ctx, "%s", %s)]], log_msg, err_var_name),
        "}",
    })
    vim.lsp.buf.format()
end)


-- overseer templates register
local function overseer_register_template()
    local overseer = require('overseer')
    overseer.register_template({
        name = "[Golang] Test current directory",
        builder = function(params)
            local env = {}
            if params.gomonkey then
                env.GOARCH = "amd64"
            end
            env.CONF_PATH = vim.fn.getcwd() .. "/conf"
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
            env.CONF_PATH = vim.fn.getcwd() .. "/conf"
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
overseer_register_template()
