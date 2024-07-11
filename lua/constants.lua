local conf_dir = vim.fn.stdpath('config')
local rplugin_dir = conf_dir .. "/rplugin"
return {
    conf_dir = conf_dir,
    rplugin_dir = rplugin_dir,
}
