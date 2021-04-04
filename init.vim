" vundle plugin manager
call plug#begin()

Plug 'preservim/nerdcommenter'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'neoclide/coc.nvim'

Plug 'neoclide/coc-pairs'

Plug 'puremourning/vimspector',{'do':'./install_gadget.py --enable-python --enable-c'}

Plug 'morhetz/gruvbox'

Plug 'junegunn/fzf.vim'

Plug 'tpope/vim-surround'

Plug 'voldikss/vim-floaterm'

Plug 'metakirby5/codi.vim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
" 
call plug#end()


" source my key map
source ~/.config/nvim/mymap.vim

" source plugin vimrc
let g:plugin_dir = "~/.config/nvim/plugvim/"
let s:vimrc_list = systemlist("ls ".g:plugin_dir)

for a in s:vimrc_list
    let s:temp = g:plugin_dir.a
    exe "source ".s:temp
    unlet s:temp
endfor

unlet s:vimrc_list

