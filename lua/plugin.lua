-- Packer (plugin manager)
local packer = require('packer')
packer.startup(function(use)
    -- Lsp support.
    use 'neovim/nvim-lspconfig'
    use 'folke/trouble.nvim'
    use 'kosayoda/nvim-lightbulb'
    use 'weilbith/nvim-code-action-menu'

    -- Complete.
    use 'hrsh7th/cmp-nvim-lsp-signature-help'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'onsails/lspkind.nvim' -- require by nvim-cmp configuration

    -- Git.
    use 'lewis6991/gitsigns.nvim'

    -- Treesitter.
    use 'nvim-treesitter/nvim-treesitter'
    use 'nvim-treesitter/nvim-treesitter-context'

    -- File explorer.
    use 'kyazdani42/nvim-tree.lua'

    -- Navigation.
    use 'MattesGroeger/vim-bookmarks'
    use 'easymotion/vim-easymotion'
    use 'nvim-telescope/telescope.nvim'
    use 'simrat39/symbols-outline.nvim'
    use 'itchyny/vim-cursorword'

    -- StatusLine.
    use 'glepnir/galaxyline.nvim'
    use 'nvim-lua/lsp-status.nvim'
    -- Themes.
    use 'folke/tokyonight.nvim'
    -- use 'EdenEast/nightfox.nvim'

    -- Icons.
    use 'kyazdani42/nvim-web-devicons'

    -- Notification.
    use 'rcarriga/nvim-notify'

    -- Other.
    use 'nvim-lua/plenary.nvim' -- require by telescope
    use 'ii14/neorepl.nvim'
    use 'tpope/vim-surround'
    -- use 'fatih/vim-go'
    -- use 'ray-x/go.nvim'
    -- use 'ray-x/guihua.lua'
end)

require('plug-config/nvim-notify')
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
require('plug-config/nvim-lightbulb')
require('plug-config/nvim-code-action-menu')
-- Themes
require('themes/idelike')
