return {
    setup = function()
        vim.notify = require('notify')
        vim.notify.setup {
            background_colour = "NotifyBackground",
            fps = 60,
            level = 2,
            minimum_width = 50,
            render = "default",
            stages = "fade_in_slide_out",
            timeout = 5000,
            top_down = false
        }
    end
}
-- Example.
--[[
local plugin = "My Awesome Plugin"

vim.notify("This is an error message.\nSomething went wrong!", "error", {
  title = plugin,
  on_open = function(win)
    vim.notify("Attempting recovery.", vim.log.levels.WARN, {
      title = plugin,
    })
    local timer = vim.loop.new_timer()
    timer:start(2000, 0, function()
      vim.notify({ "Fixing problem.", "Please wait..." }, "info", {
        title = plugin,
        timeout = 3000,
        on_close = function()
          vim.notify("Problem solved", nil, { title = plugin })
          vim.notify("Error code 0x0395AF", 1, { title = plugin })
        end,
      })
    end)
  end,
  render = 'default'
})
]]
