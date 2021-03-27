let g:coc_suggest_disable = 0

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()

" inoremap <silent><expr> <c-j> coc#refresh()
nnoremap <silent> <leader>h :call CocActionAsync('doHover')<cr>
nnoremap <silent> <leader>f <Plug>(coc-fix-current)
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gt <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
xmap if <Plug>(coc-funcobj-i) 
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" edit config
nnoremap <leader>ec :vsp ~/.config/nvim/plugvim/coc.nvim.vim<cr>

" coc-translator
nmap <leader>tr <Plug>(coc-translator-p)

nmap <Tab> :CocList <cr>

" coc-snippets
" Use <C-l> for trigger snippet expand.
" imap <C-e> <Plug>(coc-snippets-expand)
"
" Use <C-j> for select text for visual placeholder of snippet.  vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)


" coc-terminal
nmap <leader>te <Plug>(coc-terminal-toggle)
