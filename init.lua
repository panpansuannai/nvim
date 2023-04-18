-- vim.o.runtime = vim.o.runtime.."~/.config/nvim"

-- vim-plug load plugins.
vim.fn["plug#begin"]()
-- Lsp support.
vim.cmd("Plug 'neovim/nvim-lspconfig'")
vim.cmd("Plug 'folke/trouble.nvim'")
vim.cmd("Plug 'nvimdev/lspsaga.nvim'")

-- Complete.
vim.cmd("Plug 'hrsh7th/cmp-nvim-lsp-signature-help'")
vim.cmd("Plug 'hrsh7th/cmp-nvim-lsp'")
vim.cmd("Plug 'hrsh7th/cmp-buffer'")
vim.cmd("Plug 'hrsh7th/cmp-path'")
vim.cmd("Plug 'hrsh7th/cmp-cmdline'")
vim.cmd("Plug 'hrsh7th/nvim-cmp'")
vim.cmd("Plug 'hrsh7th/cmp-vsnip'")
vim.cmd("Plug 'hrsh7th/vim-vsnip'")
vim.cmd("Plug 'onsails/lspkind.nvim'") -- require by nvim-cmp configuration

-- Git.
vim.cmd("Plug 'lewis6991/gitsigns.nvim'")

-- Treesitter.
vim.cmd("Plug 'nvim-treesitter/nvim-treesitter'")
vim.cmd("Plug 'nvim-treesitter/nvim-treesitter-context'")

-- File explorer.
vim.cmd("Plug 'kyazdani42/nvim-tree.lua'")

-- Navigation.
vim.cmd("Plug 'MattesGroeger/vim-bookmarks'")
vim.cmd("Plug 'easymotion/vim-easymotion'")
vim.cmd("Plug 'nvim-telescope/telescope.nvim'")
vim.cmd("Plug 'simrat39/symbols-outline.nvim'")
vim.cmd("Plug 'itchyny/vim-cursorword'")

-- Themes.
vim.cmd("Plug 'folke/tokyonight.nvim'")
-- vim.cmd("Plug 'EdenEast/nightfox.nvim'")

-- StatusLine.
vim.cmd("Plug 'glepnir/galaxyline.nvim'")
vim.cmd("Plug 'nvim-lua/lsp-status.nvim'")

-- Icons.
vim.cmd("Plug 'kyazdani42/nvim-web-devicons'")

-- Other.
vim.cmd("Plug 'nvim-lua/plenary.nvim'") -- require by telescope
vim.cmd("Plug 'tpope/vim-surround'")
-- vim.cmd("Plug 'fatih/vim-go'")
-- vim.cmd("Plug 'ray-x/go.nvim'")
-- vim.cmd("Plug 'ray-x/guihua.lua'")
vim.fn["plug#end"]()

require('global-config')
require("plug-config/nvim-tree")
require("plug-config/lspconfig")
require("plug-config/telescope")
require("plug-config/nvim-treesitter")
require("plug-config/treesitter-context")
require("plug-config/trouble")
require("plug-config/nvim-cmp")
require("plug-config/symbols-outline")
require("plug-config/gitsigns")
require('plug-config/bookmarks')
-- Themes
require('themes/idelike')
