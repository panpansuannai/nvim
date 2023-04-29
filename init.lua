local lazypath = vim.fn.stdpath("config") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('global-config')
require('lazy').setup({
    -- LSP
    { 'neovim/nvim-lspconfig', config = function() require('plug-config/lspconfig') end},
    { 'folke/trouble.nvim', config = function() require('plug-config/trouble') end},
    { 'kosayoda/nvim-lightbulb', config = function() require('plug-config/nvim-lightbulb') end },
    { 'weilbith/nvim-code-action-menu', config = function() require('plug-config/nvim-code-action-menu') end },

    -- Compeletion
	{ 'hrsh7th/nvim-cmp', dependencies = {
        'hrsh7th/cmp-nvim-lsp-signature-help',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/vim-vsnip',
        'onsails/lspkind.nvim', -- require by nvim-cmp configuration
    }, config = function() require('plug-config/nvim-cmp') end },

    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', config=function() require('plug-config/nvim-treesitter') end },
    -- { 'nvim-treesitter/nvim-treesitter-context', config = function() require('plug-config/treesitter-context') end },

    -- Git
    { 'lewis6991/gitsigns.nvim', config = function() require('plug-config/gitsigns') end },

    -- File Explore
    {'kyazdani42/nvim-tree.lua', config=function() require('plug-config/nvim-tree') end},

    -- Navigation.
    { 'MattesGroeger/vim-bookmarks', config = function() require('plug-config/bookmarks') end },
    'easymotion/vim-easymotion',
    {'nvim-telescope/telescope.nvim', config = function() require('plug-config/telescope') end}, 
    { 'simrat39/symbols-outline.nvim', config = function() require('plug-config/symbols-outline') end },
    'itchyny/vim-cursorword',

    -- StatusLine.
    { 'glepnir/galaxyline.nvim', config = function() require('themes/idelike') end },
    'nvim-lua/lsp-status.nvim',

    -- Themes.
    { 'folke/tokyonight.nvim', config = function() vim.cmd("colorscheme tokyonight-night") end },
    -- 'EdenEast/nightfox.nvim',

    -- Icons.
    'kyazdani42/nvim-web-devicons',

    -- Notification.
    {'rcarriga/nvim-notify', config = function()
        require('plug-config/nvim-notify')
    end},

    -- Other.
    'nvim-lua/plenary.nvim', -- require by telescope
    'ii14/neorepl.nvim',
    'tpope/vim-surround',
    -- 'fatih/vim-go',
    -- 'ray-x/go.nvim',
    -- 'ray-x/guihua.lua',
}, {
    root = vim.fn.stdpath('config').."/lazy"
})
