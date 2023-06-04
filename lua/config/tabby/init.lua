return {
    setup = function()
        local theme = {
            fill = 'TabLineFill',
            -- Also you can do this: fill = { fg='#f2e9de', bg='#907aa9', style='italic' }
            head = 'TabLine',
            current_tab = 'TabLineSel',
            tab = 'TabLine',
            win = 'TabLine',
            tail = 'TabLine',
        }
        vim.api.nvim_create_user_command("TabName", function(data)
            if data.args == "" then
                vim.notify("Tab name is empty!", vim.log.levels.WARN, {
                    title = "设置Tab名失败"
                })
                return
            end
            vim.t.custom_name = data.args
        end, {})
        require('tabby.tabline').set(function(line)
            return {
                {
                    { '  ', hl = theme.head },
                    line.sep('', theme.head, theme.fill),
                },
                line.tabs().foreach(function(tab)
                    local hl = tab.is_current() and theme.current_tab or theme.tab
                    local tab_name = "[no name]"
                    for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab.id)) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        local buf_name = vim.api.nvim_buf_get_name(buf)
                        if string.match(buf_name, "NvimTree") == nil then
                            tab_name = vim.fn.fnamemodify(buf_name, ":t")
                            break
                        end
                    end
                    if vim.t[tab.id] ~= nil and vim.t[tab.id].custom_name ~= nil then
                        tab_name = vim.t[tab.id].custom_name
                    end
                    local auto_close = require('utils.tab').query_tab_auto_close(tab.id)
                    local icon = ''
                    if tab.is_current() and auto_close then
                        icon = ''
                    else
                        tab.is_current()
                        icon = ''
                    end
                    return {
                        line.sep('', hl, theme.fill),
                        icon,
                        tab.number(),
                        -- tab.name(),
                        tab_name,
                        tab.close_btn(''),
                        line.sep('', hl, theme.fill),
                        hl = hl,
                        margin = ' ',
                    }
                end),
                line.spacer(),
                line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
                    return {
                        line.sep('', theme.win, theme.fill),
                        win.is_current() and '' or '',
                        win.buf_name(),
                        line.sep('', theme.win, theme.fill),
                        hl = theme.win,
                        margin = ' ',
                    }
                end),
                {
                    line.sep('', theme.tail, theme.fill),
                    { '  ', hl = theme.tail },
                },
                hl = theme.fill,
            }
        end)
    end
}
