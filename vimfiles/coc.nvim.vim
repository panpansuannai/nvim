" edit config
nnoremap <leader>ec :edit ~/.config/nvim/vimfiles/coc.nvim.vim<cr>

let g:coc_suggest_disable = 0 
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-vimlsp', 'coc-translator', 'coc-terminal', 'coc-snippets', 'coc-python', 'coc-json', 'coc-java', 'coc-highlight', 'coc-fzf-preview', 'coc-explorer', 'coc-cmake', 'coc-clangd','coc-vimtex', 'coc-lua']



" use <tab> for trigger completion and navigate to the next complete item
 function! s:check_back_space() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1]  =~# '\s'
 endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

inoremap <silent><expr> <c-j> coc#refresh()
nnoremap <silent> <leader>h :call CocActionAsync('doHover')<cr>
" nnoremap <silent> <leader>f <Plug>(coc-fix-current)
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



nmap <Tab> :CocList <cr>

nmap <leader>f  <Plug>(coc-format-selected)
xmap <leader>f  <Plug>(coc-format-selected)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)


" coc-terminal
" nmap <leader>te <Plug>(coc-terminal-toggle)

" coc-explorer
nnoremap <leader>ee :CocCommand explorer<cr>

" coc-translator
nmap <leader>tr <Plug>(coc-translator-p)
