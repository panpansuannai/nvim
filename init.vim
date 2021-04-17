" vundle plugin manager
set runtimepath+=~/.config/nvim

" my vim plugin files directory
let s:vimfilespath='~/.config/nvim/vimfiles/'

" use vim-plug
call plug#begin()

Plug 'preservim/nerdcommenter'     " comment plugin

" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

Plug 'neoclide/coc.nvim'           " language client

Plug 'neoclide/coc-pairs'          " auto pair

Plug 'puremourning/vimspector',{'do':'./install_gadget.py --enable-python --enable-c'}    " debugger

"Plug 'morhetz/gruvbox'

Plug 'tpope/vim-surround'          " 

Plug 'voldikss/vim-floaterm'       " call a float window terminal

Plug 'metakirby5/codi.vim'         " 

Plug 'lervag/vimtex'               " latex plugin

Plug 'Yggdroot/indentLine'         "

Plug 'glepnir/galaxyline.nvim' , {'branch': 'main'}  " statuline

Plug 'kyazdani42/nvim-web-devicons'                  " use icon in galaxyline 

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}   " tree-sitter

Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }   " fuzy plugin

Plug 'notomo/gesture.nvim'        " support gesture

Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }    " show my key map
" Plug 'AckslD/nvim-whichkey-setup.lua'
"
Plug 'airblade/vim-gitgutter'     " show which line has changed
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

