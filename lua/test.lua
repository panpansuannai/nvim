local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

input = Input({
  relative = "win",
  position = {
        row = 0,
        col = "80%",
    },
  size = {
    height = "100%",
    width = "20%",
  },
  border = {
    style = "single",
    text = {
      top = "[Howdy?]",
      top_align = "center",
    },
  },
  win_options = {
    winhighlight = "Normal:Normal,FloatBorder:Normal",
  },
}, {
  prompt = "> ",
  default_value = "",
  on_close = function()
    print("Input Closed!")
  end,
  on_submit = function(value)
    print("Input Submitted: " .. value)
  end,
})

return input
