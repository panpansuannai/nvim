" vundle plugin manager
set runtimepath+=~/.config/nvim

" my vim plugin files directory
let s:vimfilespath='~/.config/nvim/vimfiles/'

" use vim-plug
call plug#begin()

Plug 'preservim/nerdcommenter'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'neoclide/coc.nvim'

Plug 'neoclide/coc-pairs'

Plug 'puremourning/vimspector',{'do':'./install_gadget.py --enable-python --enable-c'}

"Plug 'morhetz/gruvbox'

Plug 'tpope/vim-surround'

Plug 'voldikss/vim-floaterm'

Plug 'metakirby5/codi.vim'

Plug 'lervag/vimtex'

Plug 'Yggdroot/indentLine'
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

