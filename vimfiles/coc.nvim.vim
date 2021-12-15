" edit config
nnoremap <leader>ec :edit ~/.config/nvim/vimfiles/coc.nvim.vim<cr>

let g:coc_suggest_disable = 0 
let g:coc_global_extensions = ['coc-vimlsp', 'coc-translator', 'coc-terminal', 'coc-snippets','coc-json', 'coc-java', 'coc-highlight', 'coc-explorer', 'coc-cmake', 'coc-clangd','coc-vimtex']

" use <tab> for trigger completion and navigate to the next complete item
 function! s:check_back_space() abort
   let col = col('.') - 1
   return !col || getline('.')[col - 1]  =~# '\s'
 endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent><expr> <C-j>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<C-j>" :
      \ coc#refresh()
inoremap <silent><expr> <C-k>
      \ pumvisible() ? "\<C-p>" :
      \ <SID>check_back_space() ? "\<C-k>" :
      \ coc#refresh()
" Press <CR> to confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

nnoremap <silent> <leader>h :call CocActionAsync('doHover')<cr>

nmap <silent> <leader>fx <Plug>(coc-fix-current)
nmap <silent> <leader>rf <Plug>(coc-refactor)
nmap <silent> g[ <Plug>(coc-diagnostic-prev)
nmap <silent> g] <Plug>(coc-diagnostic-next)
nmap <silent> g{ <Plug>(coc-diagnostic-prev-error)
nmap <silent> g} <Plug>(coc-diagnostic-next-error)
" float window 
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <A-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<A-f>"
  nnoremap <silent><nowait><expr> <A-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<A-b>"
  inoremap <silent><nowait><expr> <A-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : ""
  inoremap <silent><nowait><expr> <A-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : ""
  vnoremap <silent><nowait><expr> <A-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<A-f>"
  vnoremap <silent><nowait><expr> <A-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<A-b>"
endif

" Code navigation.
nmap <silent> gD <plug>(coc-declaration)
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

nmap <Tab> :CocList<cr>

" format
nmap <leader>cf  <Plug>(coc-format-selected)
vmap <leader>cf  <Plug>(coc-format-selected)
" float window
nmap <leader>cwj <Plug>(coc-float-jump)
nmap <leader>cwh <Plug>(coc-float-hide)
" rename 
nmap <leader>cr <Plug>(coc-rename)

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)


" coc-terminal
" nmap <leader>te <Plug>(coc-terminal-toggle)

" coc-explorer
nnoremap <silent> <leader>ee :CocCommand explorer<cr>

" CocList
nnoremap <leader>o :CocList outline<cr>

" coc-translator
nmap <leader>tr <Plug>(coc-translator-p)
vmap <leader>tr <Plug>(coc-translator-pv)
" coc-lightlight
autocmd CursorHold * silent call CocActionAsync('highlight')

