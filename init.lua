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

-- load global configuration
require('options-config')

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
    --[[
    {
        'mrded/nvim-lsp-notify',
        dependencies = { 'rcarriga/nvim-notify' },
        config = function()
            require('lsp-notify').setup({})
        end
    },
    ]]
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
    { 'nvim-treesitter/playground',      dependencies = { 'nvim-treesitter/nvim-treesitter' } },
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
    { 'kyazdani42/nvim-tree.lua',     config = function() require('config.nvim-tree') end },

    -- Tasks
    {
        'stevearc/overseer.nvim',
        config = function()
            require('config.overseer').setup()
            require('utils.keymap').register_module(require('config.overseer.keymap'))
        end,
    },

    -- Navigation.
    {
        "cbochs/grapple.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        'MattesGroeger/vim-bookmarks',
        lazy = false,
        config = function()
            require('config.bookmarks').setup()
        end
    },
    {
        'nvim-telescope/telescope.nvim',
        lazy = false,
        dependencies = {
            'smartpde/telescope-recent-files',
            'BurntSushi/ripgrep',
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local mod = require('config.telescope')
            mod.setup()
            require('utils.keymap').register_module(require('config.telescope.keymap'))
        end
    },
    {
        'simrat39/symbols-outline.nvim',
        config = function()
            require('config.symbols-outline').setup()
            require('utils.keymap').register_module(require('config.symbols-outline'))
        end
    },
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
    -- { 'nanozuki/tabby.nvim',   config = function() require('config.tabby').setup() end },

    -- Themes.
    {
        'JoosepAlviste/palenightfall.nvim',
        cond = false,
        config = function()
            vim.cmd [[colorscheme palenightfall]]
        end
    },
    {
        'folke/tokyonight.nvim',
        cond = false,
        config = function()
            vim.cmd [[colorscheme tokyonight-night]]
        end
    },
    {
        "rebelot/kanagawa.nvim",
        cond = false,
        config = function()
            vim.cmd [[colorscheme kanagawa-wave]]
            vim.cmd [[highlight! link TelescopeBorder CursorLineNr ]]
            -- 透明
            vim.cmd [[highlight Normal guibg=NONE guisp=NONE]]
            vim.cmd [[highlight SignColumn guibg=NONE guisp=NONE]]
            vim.cmd [[highlight ColorColumn guibg=NONE guisp=NONE]]
            vim.cmd [[highlight CursorColumn guibg=NONE guisp=NONE]]
            vim.cmd [[highlight CursorLineNr guibg=NONE guisp=NONE]]
            vim.cmd [[highlight LineNr guibg=NONE guisp=NONE]]
            vim.cmd [[highlight CursorLine guibg=NONE guisp=NONE]]
            vim.cmd [[highlight! link WinSeparator CursorLine]]
        end,
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
    },
    {
        'AlexvZyl/nordic.nvim',
        lazy = false,
        cond = false,
        priority = 1000,
        config = function()
            require('nordic').setup {
                transparent_bg = true,
                brighter_border = true,
                reduce_blue = false,
                bold_keywork = true,
            }
            require 'nordic'.load()
        end
    },
    {
        "catppuccin/nvim",
        cond = true,
        name = "catppuccin",
        config = function()
            vim.cmd('set termguicolors')
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
        -- 有展示问题
        --"lukas-reineke/indent-blankline.nvim", config = function() require('config.indent-blankline').setup() end
    },

    -- UI
    {
        'stevearc/dressing.nvim',
    },

    -- Animation
    -- { 'echasnovski/mini.animate', config = function() require('config.mini-animate').setup() end },

    -- Highlight
    {
        'brenoprata10/nvim-highlight-colors',
        config = function()
            require('nvim-highlight-colors').setup()
            vim.api.nvim_set_option('t_Co', '256')
        end
    },

    -- Other.
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

-- Load autocmd configuration
require('autocmd-config').setup()

-- Do key mapping.
require('utils.keymap').apply_modules_keymap()

-- Load plugin
vim.cmd [[
if exists('g:loaded_myplugin')
    finish
endif
let g:loaded_myplugin = 1

function! s:RequirePlugin(host) abort
    return jobstart([stdpath('config') . '/rplugin/myplugin/myplugin'], {'rpc': v:true})
endfunction

call remote#host#Register('my_plugin', 'x', function('s:RequirePlugin'))
call remote#host#RegisterPlugin('my_plugin', '0', [
    \ {'type': 'function', 'name': 'Plugtest', 'sync': 0, 'opts': {}},
    \ {'type': 'function', 'name': 'CreateMR', 'sync': 0, 'opts': {}},
    \ {'type': 'function', 'name': 'ListOpenedMR', 'sync': 0, 'opts': {}},
    \ {'type': 'autocmd', 'name': 'VimEnter', 'sync': 0, 'opts': {'group': 'ExmplNvGoClientGrp', 'pattern': '*'}},
    \ ])

]]
