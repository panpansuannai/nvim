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
-- highlight Normal guibg=NONE guisp=NONE
-- highlight the yanked text
vim.cmd([[
augroup LuaHighlight
    autocmd!
      autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
    augroup END
]])

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>tt', '<cmd>tabnew<cr>')
vim.keymap.set('n', '<leader>te', '<cmd>tabe<cr>')
vim.keymap.set('n', '<leader>tc', '<cmd>tabclose<cr>')
vim.keymap.set('n', '<leader>tl', '<cmd>tabnext<cr>')
vim.keymap.set('n', '<leader>th', '<cmd>tabprevious<cr>')
vim.keymap.set('n', '<leader>to', '<cmd>tabonly<cr>')

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
vim.keymap.set('n', '<leader>ev','<cmd>edit $MYVIMRC<cr>')
vim.keymap.set('n', '<leader>qq', '<cmd>wqa!<cr>')
vim.keymap.set('n', "<leader>[", '^')
vim.keymap.set('n', "<leader>]", '$')
