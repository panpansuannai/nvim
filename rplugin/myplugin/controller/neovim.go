package controller

import (
	"fmt"

	"github.com/martinlindhe/notify"
)

func (ctrl *Controller) nvimNotify(title, format string, args ...interface{}) {
	err := ctrl.Nvim.ExecLua(`
        local arg = {...}
        require('notify').notify(arg[2], "info", {
            title = arg[1],
            on_open = function(win)
                vim.api.nvim_win_set_option(win, 'wrap', true)
                local buf = vim.api.nvim_win_get_buf(win)
                vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
            end,
            timeout = 5000
        })
    `, nil, title, fmt.Sprintf(format, args...))
	if err != nil {
		notify.Alert(NeovimStr, PluginName, fmt.Sprintf("call nvim notify err:  %v", err), "")
	}
}

func (ctrl *Controller) getPosition() (Position, error) {
	result := make([]int, 2)
	err := ctrl.Nvim.ExecLua(`
        return vim.api.nvim_win_get_cursor(0)
    `, result, nil)
	if err != nil {
		ctrl.nvimNotify("MyPlug Error", fmt.Sprintf("err: %v", err))
		return Position{}, err
	}
	return Position{
		Row: result[0],
		Col: result[1],
	}, nil
}

func (ctrl *Controller) getCursorFunction() (string, error) {
	result := ""
	err := ctrl.Nvim.ExecLua(cursorFuncLua, &result, nil)
	if err != nil {
		ctrl.nvimNotify("MyPlug Error", fmt.Sprintf("err: %v", err))
		return "", err
	}
	return result, nil
}

var cursorFuncLua = `
    local cur_node = vim.treesitter.get_node()
    -- find function
    local function_node = require('utils.treesitter').find_nearest_parent(cur_node,
        { "function_declaration", "method_declaration" })
    if function_node == nil then
        vim.notify("not in function", vim.log.levels.WARN)
        return
    end
    return vim.treesitter.get_node_text(function_node, 0)
    `

var logErrStmts = `
    local cur_node = vim.treesitter.get_node()
    -- find function
    local function_node = require('utils.treesitter').find_nearest_parent(cur_node,
        { "function_declaration", "method_declaration" })
    if function_node == nil then
        vim.notify("not in function", vim.log.levels.WARN)
        return
    end
    local fname = nil
    local is_method = false
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
    local reciever_type = nil
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
    log_msg = log_msg .. fname .. ""
    local _, _, row, _ = cur_node:range(false)
    vim.api.nvim_buf_set_lines(0, row+1, row+1, false, {
        [[logger.Info(ctx, "]] .. log_msg .. [[")]],
    })
    vim.lsp.buf.format()
`
