vim.o.showtabline = 2
vim.o.laststatus = 3
vim.o.compatible = false
vim.cmd('filetype off')
vim.cmd('syntax on')

-- split a window to show substitute
vim.o.inccommand = 'split'
vim.o.updatetime = 2000
vim.o.timeoutlen = 700

vim.o.foldmethod = "expr"
-- vim.o.foldcolumn = 1
vim.o.number = true
vim.o.numberwidth = 6
vim.o.rnu = true

-- highlight the search result
vim.o.incsearch = true

-- stop search when reach end of file
vim.o.wrapscan = false

-- command line show edit mode
vim.o.showmode = true

vim.o.encoding = "utf-8"
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.cursorline = true
vim.o.wrap = true
vim.o.hlsearch = true

-- command line height
vim.o.cmdheight = 1

-- colors
vim.o.termguicolors = true
-- colorscheme industry
-- colorscheme OceanicNext

-- 透明
vim.cmd [[highlight Normal guibg=NONE guisp=NONE]]
vim.cmd [[highlight SignColumn guibg=NONE guisp=NONE]]
vim.cmd [[highlight ColorColumn guibg=NONE guisp=NONE]]
vim.cmd [[highlight CursorColumn guibg=NONE guisp=NONE]]
vim.cmd [[highlight CursorLineNr guibg=NONE guisp=NONE]]
vim.cmd [[highlight LineNr guibg=NONE guisp=NONE]]
vim.cmd [[highlight CursorLine guibg=NONE guisp=NONE]]
vim.cmd [[highlight! link WinSeparator CursorLine]]

-- highlight the yanked text
vim.cmd([[
augroup LuaHighlight
    autocmd!
      autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
    augroup END
]])

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>tt', '<cmd>tabnew<cr>')
vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<cr>')
vim.keymap.set('n', '<leader>tl', '<cmd>tabnext<cr>')
vim.keymap.set('n', '<leader>th', '<cmd>tabprevious<cr>')
vim.keymap.set('n', '<leader>to', '<cmd>tabonly<cr>')
vim.keymap.set('n', '<leader>tT', function()
    require('utils.tab').copy_current_tab()
end)
-- 自动关闭Tab
require('utils.tab').setup_tab_close_when_leave()
vim.keymap.set('n', '<leader>tm', function()
    local notify = require('notify')
    local tab = vim.api.nvim_get_current_tabpage()
    if require('utils.tab').query_tab_auto_close(tab) then
        require('utils.tab').unset_tab_close_when_leave(tab)
        notify("取消Tab自动关闭", vim.log.levels.INFO, {
            title = "通知",
            timeout = 2000,
            -- replace = vim.t.auto_close_record,
        })
        return
    end
    require('utils.tab').set_tab_close_when_leave(tab)
    notify("Tab自动关闭", vim.log.levels.INFO, {
        title = "通知",
        timeout = 2000,
        -- replace = vim.t.auto_close_record,
    })
end)

-- window
vim.keymap.set('n', '<leader>wv', '<C-w>v<C-w>l')
vim.keymap.set('n', '<leader>ws', '<C-w>s<C-w>j')
vim.keymap.set('n', '<leader>wh', '<C-w>h')
vim.keymap.set('n', '<leader>wl', '<C-w>l')
vim.keymap.set('n', '<leader>wj', '<C-w>j')
vim.keymap.set('n', '<leader>wk', '<C-w>k')
vim.keymap.set('n', '<leader>wc', '<C-w>c')
vim.keymap.set('n', '<leader>wo', '<C-w>o')
vim.keymap.set('n', '<leader>w,', '5<C-w><')
vim.keymap.set('n', '<leader>w.', '5<C-w>>')

-- misc
vim.keymap.set('n', '<C-l>', '<cmd>nohlsearch<cr>')
vim.keymap.set('n', '<leader>ev', '<cmd>edit $MYVIMRC<cr>')
vim.keymap.set('n', '<leader>qq', '<cmd>wqa!<cr>')
vim.keymap.set('n', "<leader>[", '^')
vim.keymap.set('n', "<leader>]", '$')


vim.keymap.set('n', "<leader>sg", function()
    vim.cmd [[source ~/.config/nvim/lua/global-config.lua]]
end)

-- 测试用
vim.keymap.set('n', "<leader>za", function()
    local timer = vim.loop.new_timer()
    if timer == nil then
        require('notify').notify("timer = nil", vim.log.levels.ERROR, {})
        return
    end
    local r = nil
    timer:start(1000, 500, vim.schedule_wrap(function()
        r = require('notify').notify(vim.inspect(math.floor(vim.loop.now() / 1000)), 'info',
            { title = "倒计时10s", replace = r })
    end))
    vim.defer_fn(function() timer:stop() end, 10000)
end)

local function notice_to_relax()
    vim.defer_fn(function()
        require('notify').notify([[人生会有很多关要渡过去，道道难关道道闯，为了生活，为了追求梦想，
为了自己爱的人，也为了爱自己的人，不敢松懈下来，一直往前走，
四处奔波，拼命干活，哪有不累的呢？
每个人其实都是单枪匹马，如果没有遇到伯乐，没有遇到知己，那么一路前行，
总会感觉身心疲惫。 每个人都有自己的烦恼和忧愁，实在太累的时候，
希望你能够停下来，休息一下，这是在善待自己，不为任何人，就为你自己，
照顾好自己，才能照顾到别人。

人生很苦，生活很累，你也要允许自己累，然后好好休息，
调整好状态，才能更好地启程。]], 'warn', { title = "写码半小时了哦，休息下吧" })
        notice_to_relax()
    end, 1000 * 30 * 60)
    -- vim.g["notice_to_relax_timer"] = timer
end
notice_to_relax()

vim.keymap.set('n', "<leader>zb", function()
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
    log_msg = log_msg .. fname .. " " .. err_func_name .. " error: %v"
    local _, _, row, _ = var_decl_node:range(false)
    vim.api.nvim_buf_set_lines(0, row+1, row+1, false, {
        "if " .. err_var_name .. " != nil {",
        [[logger.Error(ctx, "]] .. log_msg .. [[", ]] .. err_var_name .. [[ )]],
        "}",
    })
    vim.lsp.buf.format()
end)

vim.keymap.set('n', "<leader>zc", function()
    local notify = require('utils.notify')
    local ctrl = notify.new_controller()
    notify.auto_post(ctrl)
    vim.defer_fn(function()
        notify.success(ctrl)
    end, 5000)
end)
