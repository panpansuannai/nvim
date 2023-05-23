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
    { 'neovim/nvim-lspconfig',         config = function() require('config.lspconfig') end },
    { 'folke/trouble.nvim',            config = function() require('config.trouble') end },
    { 'kosayoda/nvim-lightbulb',       config = function() require('config.nvim-lightbulb') end },
    { 'weilbith/nvim-code-action-menu' },
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
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
            'onsails/lspkind.nvim', -- require by nvim-cmp configuration
        },
        config = function() require('config.nvim-cmp') end
    },

    -- Treesitter
    { 'nvim-treesitter/nvim-treesitter', config = function() require('config.nvim-treesitter') end },
    -- { 'nvim-treesitter/nvim-treesitter-context', config = function() require('config.treesitter-context') end },

    -- Git
    { 'kdheepak/lazygit.nvim'},
    { 'lewis6991/gitsigns.nvim',         config = function() require('config.gitsigns').setup() end },

    -- File Explore
    { 'kyazdani42/nvim-tree.lua',        config = function() require('config.nvim-tree') end },

    -- Navigation.
    {
        'MattesGroeger/vim-bookmarks',
        config = function()
            require('config.bookmarks')
        end
    },
    { 'nvim-telescope/telescope.nvim', dependencies = {
        'smartpde/telescope-recent-files'
    },
        config = function() require('config.telescope').setup() end },
    { 'simrat39/symbols-outline.nvim', config = function() require('config.symbols-outline') end },
    'itchyny/vim-cursorword',
    {
        'phaazon/hop.nvim',
        branch = 'v2', -- optional but strongly recommended
        config = function() require('hop').setup() end
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
        config = function() require('themes/idelike') end
    },
    'nvim-lua/lsp-status.nvim',

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
        dependencies = {
            "rebelot/kanagawa.nvim"
        },
        config = function()
            require('config.nvim-notify').setup()
        end
    },

    -- Indent.
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            vim.opt.termguicolors = true
            vim.cmd [[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]]
            vim.cmd [[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]]

            vim.opt.list = true
            vim.opt.listchars:append "space:⋅"
            vim.opt.listchars:append "eol:↴"

            require("indent_blankline").setup {
                space_char_blankline = " ",
                char_highlight_list = {
                    "IndentBlanklineIndent1",
                    "IndentBlanklineIndent2",
                    "IndentBlanklineIndent3",
                    "IndentBlanklineIndent4",
                    "IndentBlanklineIndent5",
                    "IndentBlanklineIndent6",
                },
            }
        end
    },

    -- Animation
    {
        'echasnovski/mini.animate',
        version = false,
        config = function()
            require('config.mini-animate').setup()
        end
    },

    -- Other.
    'nvim-lua/plenary.nvim', -- require by telescope
    'ii14/neorepl.nvim',
    'tpope/vim-surround',
}, {
    root = vim.fn.stdpath('config') .. "/lazy",
    defaults = {
        lazy = false
    },
})
require('config.lspconfig.keymap').setup()
require('config.telescope.keymap').setup()
require('config.gitsigns.keymap').setup()
require('config.lazygit.keymap').setup()
require('config.nvim-code-action-menu').setup()
require('config.hop').setup()
