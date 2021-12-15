set nocompatible
filetype off 
syntax on

" set foldmethod=syntax
" split a window to show substitute
set inccommand=split
set updatetime=2000
set timeoutlen=700

" enable mouse
" set mouse=nv

" line number
set number numberwidth =6
" set nonu
set rnu

" highlight the search result
set incsearch

" stop search when reach end of file
set nowrapscan

syntax on

" command line show edit mode
set showmode

" show edit mode
set showmode

set encoding =utf-8
" set t_Co =256
"
" indent 
set expandtab
set autoindent
set shiftwidth =2
set tabstop =2
set softtabstop =2
set cursorline
set wrap
set hlsearch

" command line height
set cmdheight=1

" colors
colorscheme one
set termguicolors
" colorscheme industry
" colorscheme OceanicNext
highlight Normal guibg=none ctermbg=none 
" highlight the yanked text
augroup LuaHighlight
    autocmd!
      autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
    augroup END

" define key mapping {
" {{{
    let g:mapleader =' '
    
    " open current buffer in a new tab
    function! OpenBufInNewTab()
      let l:nowbuf = bufnr()
      let l:line = line(".")
      :tabnew
      execute "buf". nowbuf
      call cursor(line, 0)
      unlet nowbuf
    endfunction

    " tab 
    nnoremap <silent> <leader>tt :tabnew<cr>
    nnoremap <silent> <leader>te :tabe<cr>
    nnoremap <silent> <leader>tc :tabclose<cr>
    nnoremap <silent> <leader>tl :tabnext<cr>
    nnoremap <silent> <leader>th :tabprevious<cr>
    nnoremap <silent> <leader>to :tabonly<cr>
    nnoremap <silent> <leader>tj :tablast<cr>
    nnoremap <silent> <leader>tk :tabfirst<cr>
    nnoremap <silent> <leader>ty :call OpenBufInNewTab()<cr>

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

    nnoremap <silent> <leader>bo :call g:DeleteAllBuffersInWindow()<cr>
    nnoremap <silent> <leader>bb :buffers<cr>
    nnoremap <silent> <leader>bc :bd<cr>
    nnoremap <silent> <leader>bl :bn<cr>
    nnoremap <silent> <leader>bh :bp<cr>

    " window
    nnoremap <silent> <leader>wv <C-w>v<C-w>l
    nnoremap <silent> <leader>ws <C-w>s<C-w>j
    nnoremap <silent> <leader>wh <C-w>h
    nnoremap <silent> <leader>wl <C-w>l
    nnoremap <silent> <leader>wj <C-w>j
    nnoremap <silent> <leader>wk <C-w>k
    nnoremap <silent> <leader>wc <C-w>c
    nnoremap <silent> <leader>wo <C-w>o
    nnoremap <silent> <leader>w= 10<C-w>+
    nnoremap <silent> <leader>w- 10<C-w>-
    nnoremap <silent> <leader>w. 10<C-w>>
    nnoremap <silent> <leader>w, 10<C-w><

    vnoremap <silent> <leader>wv <C-w>v<C-w>l
    vnoremap <silent> <leader>ws <C-w>s<C-w>j
    vnoremap <silent> <leader>wh <C-w>h
    vnoremap <silent> <leader>wl <C-w>l
    vnoremap <silent> <leader>wj <C-w>j
    vnoremap <silent> <leader>wk <C-w>k
    vnoremap <silent> <leader>wc <C-w>c
    vnoremap <silent> <leader>wo <C-w>o
    vnoremap <silent> <leader>w= <C-w>+
    vnoremap <silent> <leader>w- <C-w>-
    vnoremap <silent> <leader>w. <C-w>>
    vnoremap <silent> <leader>w, <C-w><

    " improve editing
    " <leader>J in n mode to split the current line 
    nnoremap <leader>J  i<cr><esc>
    " inoremap <silent> <C-d> <Esc>dd


    " misc
    nmap <silent> <C-l> :nohlsearch<cr>
    nmap <leader>ss :w<cr>
    nmap <leader>s :w<cr>
    nmap <leader>sw :w !sudo tee%<cr>
    nmap <silent><leader>S :source $MYVIMRC<cr>
    nmap <BS> <Del>
    nnoremap <silent><C-x> :tabclose<cr>
    inoremap jk <esc>
    inoremap qi <esc>
    nnoremap <leader>m %
    autocmd FileType vim setlocal foldmethod=marker

    " edit vimrc
    nnoremap <leader>ev :edit $MYVIMRC<cr>
    nnoremap <leader>em :edit ~/.config/nvim/mymap.vim<cr>
    nnoremap <leader>es :edit ~/.config/nvim/plugvim/vimspector.vim<cr>
    nnoremap <leader>ea :edit ~/.config/nvim/plugvim/vim-airline.vim<cr>
    nnoremap <leader>qq :wqa!<cr>

    " excute current line
    nnoremap <C-e> V"ay:!<C-r>a<cr><cr>
    nnoremap <A-e> V"ay:!<C-r>a<cr>

    noremap <leader>[ ^
    noremap <leader>] $
    " update coc_status
    autocmd User CocStatusChange redraws

    " options close
    nnoremap <leader>qh :TSDisableAll highlight<cr>

    " option open
    nnoremap <leader>ah :TSEnableAll highlight<cr>
    
    " Session
    nnoremap <leader>se :mks! session.vim<cr>
    nnoremap <leader>sl :source session.vim<cr>
" }}}

" help me ajust to use 'jk' to escapy insert mode

" }
