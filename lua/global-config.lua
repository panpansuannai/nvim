local constants = require('constants')
vim.opt.rtp:prepend(constants.rplugin_dir)

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

-- navigator
-- goto next function
vim.keymap.set('n', "<leader>fj", function()
    local win = vim.api.nvim_get_current_win()
    local pos = vim.api.nvim_win_get_cursor(win)
    local found = false
    require('utils.treesitter').iter_func(function(n)
        if found then
            return
        end
        local r, c = n:range()
        if r > pos[1] then
            vim.api.nvim_win_set_cursor(win, { r + 1, c })
            found = true
        end
    end)
end)

-- goto previous function
vim.keymap.set('n', "<leader>fk", function()
    local win = vim.api.nvim_get_current_win()
    -- (1, 0)-index
    local pos = vim.api.nvim_win_get_cursor(win)
    local last_pos = { 1, 0 }
    require('utils.treesitter').iter_func(function(n)
        -- (0, 0)-index
        local r, c = n:range()
        -- convert to 1-index
        r = r + 1
        if r < pos[1] then
            last_pos = { r, c }
        end
    end)
    vim.api.nvim_win_set_cursor(win, last_pos)
end)
--[[
vim.keymap.set('n', 'j', function()
    local pos = vim.api.nvim_win_get_cursor(0)
    local ism = vim.api.nvim_exec2("!./macism", { output = true })["output"]
    if ism == "com.apple.keylayout.ABC" then
        vim.api.nvim_exec2("!./macism com.apple.keylayout.ABC", {})
    end
    vim.api.nvim_win_set_cursor(0, { pos[1] + 1, pos[2] })
end)

vim.keymap.set('n', 'k', function()
    local pos = vim.api.nvim_win_get_cursor(0)
    local ism = vim.api.nvim_exec2("!./macism", { output = true })["output"]
    if ism == "com.apple.keylayout.ABC" then
        vim.api.nvim_exec2("!./macism com.apple.keylayout.ABC", {})
    end
    vim.api.nvim_win_set_cursor(0, { pos[1] - 1, pos[2] })
end)
]]
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
vim.keymap.set('n', '<C-l>', function()
    vim.api.nvim_command("nohlsearch")
end)

vim.api.nvim_set_option_value("ignorecase", true, {})
vim.keymap.set('n', '<leader>ev', function()
    vim.cmd [[edit $MYVIMRC]]
    require('luv').chdir(require('constants').conf_dir)
end)
vim.keymap.set('n', '<leader>qq', '<cmd>wqa!<cr>')
vim.keymap.set('n', "<leader>[", '^')
vim.keymap.set('n', "<leader>]", '$')
vim.keymap.set('n', '<leader>f', 'zfi{')


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


-- 测试loading
vim.keymap.set('n', "<leader>zc", function()
    local notify = require('utils.notify')
    local ctrl = notify.new_controller()
    notify.auto_post(ctrl)
    vim.defer_fn(function()
        notify.success(ctrl)
    end, 5000)
end)


vim.keymap.set('n', "<leader>zd", function()
    local branch = vim.fn.system('git branch --show-current')
    if branch ~= nil then
        branch = string.gsub(branch, '\n', '')
    else
        vim.notify("not found current branch", vim.log.levels.INFO)
        return
    end
    vim.fn.ListOpenedMR(branch)
end)
