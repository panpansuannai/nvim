highlight link BookmarkSign CursorLineNr
highlight link BookmarkAnnotationSign CursorLineNr
highlight link BookmarkLine CursorLine
highlight link BookmarkAnnotationLine CursorLine

" Add/remove bookmark at current line 	         | mm 	:BookmarkToggle
" Add/edit/remove annotation at current          | line 	mi 	:BookmarkAnnotate <TEXT>
" Jump to next bookmark in buffer 	             | mn 	:BookmarkNext
" Jump to previous bookmark in buffer 	         | mp 	:BookmarkPrev
" Show all bookmarks (toggle) 	                 | ma 	:BookmarkShowAll
" Clear bookmarks in current buffer only 	       | mc 	:BookmarkClear
" Clear bookmarks in all buffers 	               | mx 	:BookmarkClearAll
" Move up bookmark at current line 	             | [count]mkk 	:BookmarkMoveUp [<COUNT>]
" Move down bookmark at current line 	           | [count]mjj 	:BookmarkMoveDown [<COUNT>]
" Move bookmark at current line to another line  | [count]mg 	:BookmarkMoveToLine <LINE>
" Save all bookmarks to a file 		               | :BookmarkSave <FILE_PATH>
" Load bookmarks from a file 		                 | :BookmarkLoad <FILE_PATH>

" default key map
let g:bookmark_no_default_key_mappings = 0
let g:bookmark_sign = 'B'
let g:bookmark_annotation_sign = 'B*' 
let g:bookmark_save_per_working_dir = 0
let g:bookmark_show_toggle_warning = 0
let g:bookmark_auto_save = 0
let g:bookmark_manage_per_buffer = 1
let g:bookmark_auto_save_file = "$HOME/.config/nvim/bookmarks"
let g:bookmark_auto_close = 1
let g:bookmark_highlight_lines = 1
let g:bookmark_display_annotation = 1
