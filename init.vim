" vundle plugin manager
set runtimepath+=~/.config/nvim

" my vim plugin files directory
let s:vimfilespath='~/.config/nvim/vimfiles/'
let g:vimsessionpath='~/.config/nvim/sessions/'

" use vim-plug
call plug#begin()

" Plug 'neoclide/coc.nvim'           " language client

" Plug 'neoclide/coc-pairs'          " auto pair

" debugger

"Plug 'morhetz/gruvbox'

Plug 'tpope/vim-surround'

Plug 'voldikss/vim-floaterm'       " call a float window terminal

Plug 'Yggdroot/indentLine'         " show indent

Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}  " statuline

Plug 'kyazdani42/nvim-web-devicons'                  " use icon in galaxyline 

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}   " tree-sitter highlight

" Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }   " fuzy search plugin

"Plug 'notomo/gesture.nvim'        " support gesture

Plug 'itchyny/vim-cursorword'      " outstand the word at cursor

" Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }    " show my key map


Plug 'MattesGroeger/vim-bookmarks' " bookmarks

Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

Plug 'folke/trouble.nvim'

Plug 'kyazdani42/nvim-tree.lua'

Plug 'easymotion/vim-easymotion'
Plug 'folke/lsp-colors.nvim'

Plug 'simrat39/symbols-outline.nvim'

Plug 'EdenEast/nightfox.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Plug 'fatih/vim-go'
" Plug 'ray-x/go.nvim'
" Plug 'ray-x/guihua.lua'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lewis6991/gitsigns.nvim'
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'onsails/lspkind.nvim'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvimdev/lspsaga.nvim'
call plug#end()


" source my key map
source ~/.config/nvim/mymap.vim

" source plugin vimrc
let s:vimrc_list = systemlist("ls ".s:vimfilespath)
for a in s:vimrc_list
    let s:temp = s:vimfilespath.a
    exe "source ".s:temp
    unlet s:temp
endfor

