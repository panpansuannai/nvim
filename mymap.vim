" 自定义映射

set nocompatible
filetype off 
syntax on

" enable mouse
set mouse =a

" line number
set number numberwidth =6
set rnu

" highlight the search result
set incsearch

syntax on

" command line show edit mode
set showmode

" show edit mode
set showmode

set encoding =utf-8
set t_Co =256
set autoindent
set shiftwidth =2
set tabstop =2
set softtabstop =2
set expandtab
set cursorline
set wrap
set hlsearch

" command line height
set cmdheight=1

" colors
"
colorscheme gruvbox
highlight Normal ctermbg=none guibg=NONE

" define key mapping {
    let g:mapleader =' '
    
    " tab 
    nnoremap <leader>tt :tabnew<cr>
    nnoremap <leader>te :tabe<cr>
    nnoremap <leader>tc :tabclose<cr>
    nnoremap <leader>tl :tabnext<cr>
    nnoremap <leader>th :tabprevious<cr>
    nnoremap <leader>to :tabonly<cr>
    nnoremap <leader>tj :tablast<cr>
    nnoremap <leader>tk :tabfirst<cr>

    "paste
    nnoremap <leader>p" ""p
    nnoremap <leader>p0 "0p
    nnoremap <leader>p1 "1p
    nnoremap <leader>p2 "2p
    nnoremap <leader>p3 "3p
    nnoremap <leader>p4 "4p
    nnoremap <leader>p5 "5p
    nnoremap <leader>p6 "6p

    "system clipboard
    nnoremap <leader>p= "+p
    nnoremap <leader>yc "+yy

    " buffers 
    function! g:DeleteAllBuffersInWindow()
        let s:curWinNr = winnr()
        if winbufnr(s:curWinNr) == 1
            ret
        endif
        let s:curBufNr = bufnr("%")
        exe "bn"
        let s:nextBufNr = bufnr("%")
        while s:nextBufNr != s:curBufNr
            exe "bn"
            exe "bdel ".s:nextBufNr
            let s:nextBufNr = bufnr("%")
        endwhile
    endfun

    nnoremap <leader>bo :call g:DeleteAllBuffersInWindow()<cr>
    nnoremap <leader>bb :buffers<cr>
    nnoremap <leader>bc :bd<cr>
    nnoremap <leader>bl :bn<cr>
    nnoremap <leader>bh :bp<cr>

    " insert mode
    inoremap <silent> <C-l> <esc>A
    inoremap <silent> <C-h> <Esc>I
    inoremap <silent> <C-o> <Esc>o
    inoremap <silent> <C-O> <Esc>O
    inoremap <silent> <C-d> <Esc>dd

    " window
    nnoremap <silent> <leader>wv <C-w>v<C-w>l
    nnoremap <silent> <leader>ws <C-w>s<C-w>j
    nnoremap <silent> <leader>wh <C-w>h
    nnoremap <silent> <leader>wl <C-w>l
    nnoremap <silent> <leader>wj <C-w>j
    nnoremap <silent> <leader>wk <C-w>k
    nnoremap <silent> <leader>wc <C-w>c
    nnoremap <silent> <leader>wo <C-w>o

    " misc
    nmap <C-l> :nohlsearch<cr>
    nmap <leader>ss :w<cr>
    nmap <leader>s :w<cr>
    nmap <leader>sw :w !sudo tee%<cr>
    nmap <leader>S :source $MYVIMRC<cr>

    " edit vimrc
    nnoremap <leader>ev :vsp $MYVIMRC<cr>
    nnoremap <leader>em :vsp ~/.config/nvim/mymap.vim<cr>
    nnoremap <leader>es :vsp ~/.config/nvim/plugvim/vimspector.vim<cr>
    nnoremap <leader>ea :vsp ~/.config/nvim/plugvim/vim-airline.vim<cr>
    nnoremap <leader>qq :wqa!<cr>

" }
