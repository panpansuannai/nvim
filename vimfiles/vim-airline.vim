" let g:airline_theme='powerlineish'
" let g:airline_theme='bubblegum'
" let g:airline_theme = 'gruvbox'
" let g:airline_theme = 'base16_gruvbox_dark_hard'

let g:airline_detect_modified = 1
let g:airline_detect_paste= 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'

" tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tabnr = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#show_tab_count = 0
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#alt_sep = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_count = 1
let g:airline#extensions#tabline#exclude_preview = 0

let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#keymap#enabled = 1
let g:airline#extensions#battery = 1

let g:airline#extensions#coc#enabled = 1
