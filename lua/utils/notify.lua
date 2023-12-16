local function new_controller() return {}
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

local api = vim.api

local function render(bufnr, notif, highlights, config)
  local left_icon = notif.icon .. " "
  local max_message_width = math.max(math.max(unpack(vim.tbl_map(function(line)
    return vim.fn.strchars(line)
  end, notif.message))))
  local right_title = notif.title[2]
  local left_title = notif.title[1]
  local title_accum = vim.str_utfindex(left_icon)
    + vim.str_utfindex(right_title)
    + vim.str_utfindex(left_title)

  local left_buffer = string.rep(" ", math.max(0, max_message_width - title_accum))

  local namespace = api.nvim_create_namespace("utils")
  api.nvim_buf_set_lines(bufnr, 0, 1, false, { "", "" })
  api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
    virt_text = {
      { " " },
      { left_icon, highlights.icon },
      { left_title .. left_buffer, highlights.title },
    },
    virt_text_win_col = 0,
    priority = 10,
  })
  api.nvim_buf_set_extmark(bufnr, namespace, 0, 0, {
    virt_text = { { " " }, { right_title, highlights.title }, { " " } },
    virt_text_pos = "right_align",
    priority = 10,
  })
  api.nvim_buf_set_extmark(bufnr, namespace, 1, 0, {
    virt_text = {
      {
        string.rep(
          "━",
          math.max(vim.str_utfindex(left_buffer) + title_accum + 2, config.minimum_width())
        ),
        highlights.border,
      },
    },
    virt_text_win_col = 0,
    priority = 10,
  })
  api.nvim_buf_set_lines(bufnr, 2, -1, false, notif.message)

  api.nvim_buf_set_extmark(bufnr, namespace, 2, 0, {
    hl_group = highlights.body,
    end_line = 1 + #notif.message,
    end_col = #notif.message[#notif.message],
    priority = 50, -- Allow treesitter to override
  })
end



local M = {
    new_controller = new_controller,
    post = post,
    auto_post = auto_post,
    success = success,
    render = render,
}
return M
