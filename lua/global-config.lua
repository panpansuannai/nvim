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
-- vim.cmd[[highlight Normal guibg=NONE guisp=NONE]]
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
-- 自动关闭Tab
require('utils.tab').setup_tab_close_when_leave()
vim.keymap.set('n', 'M', function()
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
