let s:spector_json_path = "~/.config/nvim/plugged/vimspector/vimspector.json"
let g:vimspector_sidebar_width=30
let g:vimspector_bottombar_height=6
let g:vimspector_terminal_minwidth=20

" move .vimspactor.json to current directory
function! g:Link_spector_json()
    let l:temp = "cp ".s:spector_json_path." ./.vimspector.json"
    let l:exist = system("ls .vimspector.json")
    if l:exist
        echom "Had vimspector configure file"
        return 
    endif
    execute system(l:temp)
endfunction

" create a soft link of vimspector.json in current directory
nnoremap <leader>db :call g:Link_spector_json()<cr>

" key map
nmap <leader>dd <Plug>VimspectorRestart
nmap <leader>ds :VimspectorReset<Cr>
nmap <leader>de :VimspectorEval -exec 
" Frame
nmap <leader>dj <Plug>VimspectorUpFrame
nmap <leader>dk <Plug>VimspectorDownFrame 

nmap <leader>di <Plug>VimspectorBalloonEval
nmap <leader>dp <Plug>VimspectorPause
nmap <leader>dw :VimspectorWatch  
nmap <leader>dr :VimspectorEval -exec info reg<cr>
nmap <leader>dcab :call vimspector#ClearBreakpoints()<cr> 

nmap <F1> <Plug>VimspectorStepOver
nmap <F2> <Plug>VimspectorStepInto
nmap <F3> <Plug>VimspectorStepOut
nmap <F4> <Plug>VimspectorRunToCursor

nmap <F5> <Plug>VimspectorContinue
nmap <F6> <Plug>VimspectorUpFrame
nmap <F7> <Plug>VimspectorDownFrame

nmap <F9> <Plug>VimspectorToggleBreakpoint
nnoremap <leader><F9> :call vimspector#ClearBreakpoints()<Cr> 

nmap <F10> <Plug>VimspectorToggleConditionalBreakpoint
nmap <leader><F10> <Plug>VimspectorAddFunctionBreakpoint

nmap <leader>d<BS> :call vimspector#DeleteWatch()<Cr>
