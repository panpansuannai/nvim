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

local function transparent_bg()
        -- 透明
        vim.cmd [[highlight Normal guibg=NONE guisp=NONE]]
        vim.cmd [[highlight SignColumn guibg=NONE guisp=NONE]]
        vim.cmd [[highlight ColorColumn guibg=NONE guisp=NONE]]
        vim.cmd [[highlight CursorColumn guibg=NONE guisp=NONE]]
        vim.cmd [[highlight CursorLineNr guibg=NONE guisp=NONE]]
        vim.cmd [[highlight LineNr guibg=NONE guisp=NONE]]
        vim.cmd [[highlight CursorLine guibg=NONE guisp=NONE]]
        vim.cmd [[highlight DiagnosticSignInfo guibg=NONE guisp=NONE]]
        vim.cmd [[highlight DiagnosticSignError guibg=NONE guisp=NONE]]
        vim.cmd [[highlight DiagnosticSignWarn guibg=NONE guisp=NONE]]
        vim.cmd [[highlight DiagnosticSignHint guibg=NONE guisp=NONE]]
        vim.cmd [[highlight! link WinSeparator CursorLine]]
end

-- load global configuration
require('options-config')

require('lazy').setup({
        -- AI
        {
                "yetone/avante.nvim",
                -- 如果您想从源代码构建，请执行 `make BUILD_FROM_SOURCE=true`
                -- ⚠️ 一定要加上这一行配置！！！！！
                build = vim.fn.has("win32") ~= 0
                    and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
                    or "make",
                event = "VeryLazy",
                version = false, -- 永远不要将此值设置为 "*"！永远不要！
                ---@module 'avante'
                ---@type avante.Config
                opts = {
                        -- 在此处添加任何选项
                        -- 例如
                        provider = "openai",
                        providers = {
                                openai = {
                                        endpoint = "https://compass.llm.shopee.io/compass-api/v1",
                                        model = "compass-max",
                                        timeout = 30000, -- Timeout in milliseconds
                                        extra_request_body = {
                                                temperature = 0.75,
                                                max_tokens = 20480,
                                        },
                                },
                                moonshot = {
                                        endpoint = "https://api.moonshot.ai/v1",
                                        model = "kimi-k2-0711-preview",
                                        timeout = 30000, -- 超时时间（毫秒）
                                        extra_request_body = {
                                                temperature = 0.75,
                                                max_tokens = 32768,
                                        },
                                },
                        },
                },
                dependencies = {
                        "nvim-lua/plenary.nvim",
                        "MunifTanjim/nui.nvim",
                        --- 以下依赖项是可选的，
                        "echasnovski/mini.pick", -- 用于文件选择器提供者 mini.pick
                        "nvim-telescope/telescope.nvim", -- 用于文件选择器提供者 telescope
                        "hrsh7th/nvim-cmp", -- avante 命令和提及的自动完成
                        "ibhagwan/fzf-lua", -- 用于文件选择器提供者 fzf
                        "nvim-tree/nvim-web-devicons", -- 或 echasnovski/mini.icons
                        "zbirenbaum/copilot.lua", -- 用于 providers='copilot'
                        {
                                -- 支持图像粘贴
                                "HakonHarnes/img-clip.nvim",
                                event = "VeryLazy",
                                opts = {
                                        -- 推荐设置
                                        default = {
                                                embed_image_as_base64 = false,
                                                prompt_for_file_name = false,
                                                drag_and_drop = {
                                                        insert_mode = true,
                                                },
                                                -- Windows 用户必需
                                                use_absolute_path = true,
                                        },
                                },
                        },
                        {
                                -- 如果您有 lazy=true，请确保正确设置
                                'MeanderingProgrammer/render-markdown.nvim',
                                opts = {
                                        file_types = { "markdown", "Avante" },
                                },
                                ft = { "markdown", "Avante" },
                        },
                },
        },
        -- LSP
        {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                        library = {
                                -- See the configuration section for more details
                                -- Load luvit types when the `vim.uv` word is found
                                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                        },
                },
        },
        { -- optional cmp completion source for require statements and module annotations
                "hrsh7th/nvim-cmp",
                opts = function(_, opts)
                        opts.sources = opts.sources or {}
                        table.insert(opts.sources, {
                                name = "lazydev",
                                group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                        })
                end,
        },
        { -- optional blink completion source for require statements and module annotations
                "saghen/blink.cmp",
                opts = {
                        sources = {
                                -- add lazydev to your completion providers
                                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                                providers = {
                                        lazydev = {
                                                name = "LazyDev",
                                                module = "lazydev.integrations.blink",
                                                -- make lazydev completions top priority (see `:h blink.cmp`)
                                                score_offset = 100,
                                        },
                                },
                        },
                },
        },
        -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
        {
                'neovim/nvim-lspconfig',
                config = function()
                        require('config.lspconfig').setup()
                        require('utils.keymap').register_module(require('config.lspconfig.keymap'))
                end
        },
        {
                'folke/trouble.nvim',
                config = function() require('config.trouble') end,
                dependencies = {
                        'nvim-tree/nvim-web-devicons',
                        'nvim-telescope/telescope.nvim',
                }
        },
        { 'kosayoda/nvim-lightbulb', config = function() require('config.nvim-lightbulb') end },
        {
                'weilbith/nvim-code-action-menu',
                config = function()
                        local mod = require('config.nvim-code-action-menu')
                        mod.setup()
                        require('utils.keymap').register_module(mod)
                end
        },
        -- { 'folke/neodev.nvim',       config = function() require('neodev').setup() end },

        -- Linter
        {
                "mfussenegger/nvim-lint",
                config = function()
                        require("config.nvim-lint").setup()
                end
        },

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
        { 'kyazdani42/nvim-tree.lua', config = function() require('config.nvim-tree') end },

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
                        'nvim-tree/nvim-web-devicons',
                        'nvim-treesitter/nvim-treesitter',
                        'neovim/nvim-lspconfig',
                        'nvim-telescope/telescope.nvim',
                },
                config = function() require('config.galaxyline').setup() end
        },
        'nvim-lua/lsp-status.nvim',

        -- Tabline
        {
                'seblj/nvim-tabline',
                dependencies = {
                        'nvim-tree/nvim-web-devicons',
                },
                config = function()
                        require('tabline').setup({
                                no_name = '[No Name]', -- Name for buffers with no name
                                modified_icon = '', -- Icon for showing modified buffer
                                close_icon = '', -- Icon for closing tab with mouse
                                separator = "▌", -- Separator icon on the left side
                                padding = 3, -- Prefix and suffix space
                                color_all_icons = false, -- Color devicons in active and inactive tabs
                                right_separator = false, -- Show right separator on the last tab
                                show_index = true, -- Shows the index of tab before filename
                                show_icon = true, -- Shows the devicon
                        })
                end
        },

        -- Themes.
        {
                'JoosepAlviste/palenightfall.nvim',
                cond = true,
                config = function()
                        -- vim.cmd [[colorscheme palenightfall]]
                end
        },
        {
                'folke/tokyonight.nvim',
                cond = true,
                config = function()
                        -- vim.cmd [[colorscheme tokyonight-night]]
                end
        },
        {
                "rebelot/kanagawa.nvim",
                cond = true,
                config = function()
                        require('config.themes.kanagawa').setup()
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
                cond = false,
                name = "catppuccin",
                config = function()
                        vim.cmd('set termguicolors')
                        vim.cmd('colorscheme catppuccin-mocha')
                        transparent_bg()
                end
        },
        -- 'EdenEast/nightfox.nvim',


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

        -- UI
        {
                "folke/noice.nvim",
                --event = "VeryLazy",
                opts = {},
                dependencies = {
                        -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
                        "MunifTanjim/nui.nvim",
                        -- OPTIONAL:
                        --   `nvim-notify` is only needed, if you want to use the notification view.
                        --   If not available, we use `mini` as the fallback
                        "rcarriga/nvim-notify",
                },
                config = function()
                        require('config.noice').setup()
                        transparent_bg()
                        require('utils.keymap').register_module(require('config.noice'))
                end
        },
        {
                'stevearc/dressing.nvim',
        },

        -- Animation
        -- { 'echasnovski/mini.animate', config = function() require('config.mini-animate').setup() end },

        -- Highlight
        {
                'brenoprata10/nvim-highlight-colors',
                config = function()
                        require('nvim-highlight-colors').setup({})
                        --vim.api.nvim_set_option('t_Co', '256')
                end
        },

        -- Other.
        'tpope/vim-surround',
        { 'ii14/neorepl.nvim',        config = function() require('config.neorepl').setup() end },
}, {
        root = vim.fn.stdpath('config') .. "/lazy",
        defaults = {
                lazy = false
        },
})
-- load global configuration.
require('global-config')

-- Load autocmd configuration.
require('autocmd-config').setup()

-- Load rpc plugin.
-- require('rplugin-config').setup()

-- Do key mapping.
require('utils.keymap').apply_modules_keymap()
