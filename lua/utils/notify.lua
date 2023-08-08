local function new_controller()
    return {}
end

local loading_icons = {"⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷"}
local success_icon = "✓"

local function post(ctrl, opt)
    ctrl.last = require('notify').notify(opt.msg, opt.level, {
        title = opt.title,
        icon = opt.icon,
        timeout = opt.timeout,
        replace = ctrl.last
    })
end

local function auto_post(ctrl)
    ctrl.timer = vim.loop.new_timer()
    if ctrl.timer == nil then
        require('notify').notify("timer = nil", vim.log.levels.ERROR, {})
        return
    end

    local cnt = 1
    ctrl.timer:start(1000, 300, vim.schedule_wrap(function()
        post(ctrl, {
            msg = "Please wait...",
            title = "Loading",
            icon = loading_icons[cnt % 9 + 1],
            level = vim.log.levels.INFO,
            timeout = 500,
        })
        cnt = cnt + 1
    end))
end

local function success(ctrl)
    ctrl.timer:close()
    post(ctrl, {
        msg = "Success",
        title = "Success",
        icon = success_icon,
        level = vim.log.levels.INFO,
        timeout = 1000,
    })
end


local M = {
    new_controller = new_controller,
    post = post,
    auto_post = auto_post,
    success = success,
}
return M
