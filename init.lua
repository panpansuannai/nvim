do -- Install lazy.nvim plugin manager.
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
end

require('lazy').setup({
    -- LSP
    {
        'neovim/nvim-lspconfig',
        config = function()
            require('config.lspconfig').setup()
            require('utils.keymap').register_module(require('config.lspconfig.keymap'))
        end
    },
    { 'folke/trouble.nvim',      config = function() require('config.trouble') end },
    { 'kosayoda/nvim-lightbulb', config = function() require('config.nvim-lightbulb') end },
    {
        'weilbith/nvim-code-action-menu',
        config = function()
            local mod = require('config.nvim-code-action-menu')
            mod.setup()
            require('utils.keymap').register_module(mod)
        end
    },
    {
        'mrded/nvim-lsp-notify',
        dependencies = { 'rcarriga/nvim-notify' },
        config = function()
            require('lsp-notify').setup({})
        end
    },
    { 'folke/neodev.nvim',               config = function() require('neodev').setup() end },
    -- 'fatih/vim-go',
    -- 'ray-x/go.nvim',
    -- 'ray-x/guihua.lua',

    -- Compeletion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
            'onsails/lspkind.nvim', -- require by nvim-cmp configuration
        },
        config = function() require('config.nvim-cmp').setup() end
    },

    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', config = function() require('config.nvim-treesitter') end },
    -- { 'nvim-treesitter/nvim-treesitter-context', config = function() require('config.treesitter-context') end },

    -- Git
    {
        'kdheepak/lazygit.nvim',
        config = function()
            local lazygit = require('config.lazygit')
            require('utils.keymap').register_module(lazygit)
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('config.gitsigns').setup()
            require('utils.keymap').register_module(require('config.gitsigns.keymap'))
        end
    },

    -- File Explore
    { 'kyazdani42/nvim-tree.lua',      config = function() require('config.nvim-tree') end },

    -- Navigation.
    {
        'MattesGroeger/vim-bookmarks',
        config = function()
            require('config.bookmarks')
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'smartpde/telescope-recent-files'
        },
        config = function()
            local mod = require('config.telescope')
            mod.setup()
            require('utils.keymap').register_module(require('config.telescope.keymap'))
        end
    },
    { 'simrat39/symbols-outline.nvim', config = function() require('config.symbols-outline') end },
    'itchyny/vim-cursorword',
    {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function()
            local hop = require('config.hop')
            hop.setup()
            require('utils.keymap').register_module(hop)
        end
    },

    -- StatusLine.
    {
        'glepnir/galaxyline.nvim',
        dependencies = {
            'kyazdani42/nvim-web-devicons',
            'nvim-treesitter/nvim-treesitter',
            'neovim/nvim-lspconfig',
            'nvim-telescope/telescope.nvim',
        },
        config = function() require('config.galaxyline').setup() end
    },
    'nvim-lua/lsp-status.nvim',

    -- Tabline
    { 'nanozuki/tabby.nvim',   config = function() require('config.tabby').setup() end },

    -- Themes.
    { 'folke/tokyonight.nvim' },
    { "rebelot/kanagawa.nvim", config = function() vim.cmd [[colorscheme kanagawa-wave]] end },
    {
        "catppuccin/nvim",
        cond = false,
        name = "catppuccin",
        config = function()
            vim.cmd('colorscheme catppuccin-mocha')
        end
    },
    -- 'EdenEast/nightfox.nvim',

    -- Icons.
    { 'kyazdani42/nvim-web-devicons', name = "devicons" },

    -- Notification.
    {
        'rcarriga/nvim-notify',
        dependencies = { "rebelot/kanagawa.nvim" },
        config = function()
            require('config.nvim-notify').setup()
            require('utils.keymap').register_module(require('config.nvim-notify.keymap'))
        end
    },

    -- Indent.
    {
        "lukas-reineke/indent-blankline.nvim", config = function() require('config.indent-blankline').setup() end
    },

    -- Animation
    { 'echasnovski/mini.animate',     version = false,  config = function() require('config.mini-animate').setup() end },

    -- Other.
    'nvim-lua/plenary.nvim', -- require by telescope
    {
        'VonHeikemen/fine-cmdline.nvim',
        dependencies = { 'MunifTanjim/nui.nvim' },
        config = function()
        end
    },
    'tpope/vim-surround',
    { 'ii14/neorepl.nvim', config = function() require('config.neorepl').setup() end },
}, {
    root = vim.fn.stdpath('config') .. "/lazy",
    defaults = {
        lazy = false
    },
})
-- load global configuration
require('global-config')

-- Do key mapping.
require('utils.keymap').apply_modules_keymap()
