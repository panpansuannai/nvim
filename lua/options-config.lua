vim.o.showtabline = 2
vim.o.laststatus = 3
vim.o.compatible = false
vim.cmd('filetype off')
vim.cmd('syntax on')

-- split a window to show substitute
vim.o.inccommand = 'split'
vim.o.updatetime = 1000
vim.o.timeoutlen = 700

-- vim.o.foldmethod = "expr"
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
