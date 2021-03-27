let g:spector_json_path = "~/.config/nvim/plugged/vimspector/vimspector.json"
function! g:Link_spector_json()
    let s:temp = "cp ".g:spector_json_path." ./.vimspector.json"
    let a = system("ls".s:temp)
    if a 
        echo "Had configure file"
        return 
    endif
    let a = system(s:temp)
    echo "done"
    unlet s:temp
endfunction

" create a soft link of vimspector.json in current directory
nnoremap <leader>db :call g:Link_spector_json()<cr>

" key map
nmap <leader>d <Esc>
nmap <leader>dd <Plug>VimspectorRestart
nmap <leader>ds <Plug>VimspectorStop
nmap <leader>dp <Plug>VimspectorPause
nmap <leader>dw :VimspectorWatch  
nmap <leader>dr :VimspectorEval -exec info reg<cr>
nmap <leader>dcab :call vimspector#ClearBreakpoints()<cr> 
nmap <F1> <Plug>VimspectorStepOver
nmap <F2> <Plug>VimspectorStepInto
nmap <F3> <Plug>VimspectorStepOut
nmap <F4> <Plug>VimspectorRunToCursor
nmap <F5> <Plug>VimspectorContinue
nmap <F6> :VimspectorEval -exec 
nmap <F9> <Plug>VimspectorToggleBreakpoint
nmap <leader><F9> <Plug>VimspectorToggleConditionalBreakpoint
