" edit config
nnoremap <leader>ec :edit ~/.config/nvim/vimfiles/coc.nvim.vim<cr>

let g:coc_suggest_disable = 0 
let g:coc_global_extensions = [ 'coc-tsserver', 'coc-vimlsp', 'coc-translator', 'coc-terminal', 'coc-snippets', 'coc-python', 'coc-json', 'coc-java', 'coc-highlight', 'coc-fzf-preview', 'coc-explorer', 'coc-cmake', 'coc-clangd','coc-vimtex']



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

" format
nmap <leader>cf  <Plug>(coc-format-selected)
vmap <leader>cf  <Plug>(coc-format-selected)
" float window
nmap <leader>cwj <Plug>(coc-float-jump)
nmap <leader>cwh <Plug>(coc-float-hide)
" rename 
nmap <leader>cr <Plug>(coc-rename)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)


" coc-terminal
" nmap <leader>te <Plug>(coc-terminal-toggle)

" coc-explorer
nnoremap <leader>ee :CocCommand explorer<cr>

" coc-translator
nmap <leader>tr <Plug>(coc-translator-p)
vmap <leader>tr <Plug>(coc-translator-pv)

" Remap <C-f> and <C-b> for scroll float windows/popups.
"if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <A-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <A-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <A-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <A-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <A-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <A-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"endif
