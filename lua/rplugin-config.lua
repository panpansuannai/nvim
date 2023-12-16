local setup = function()
    -- load golang plugin
    vim.cmd [[
    if exists('g:loaded_myplugin')
        finish
    endif
    let g:loaded_myplugin = 1

    function! s:RequirePlugin(host) abort
        return jobstart([stdpath('config') . '/rplugin/glugin/glugin'], {'rpc': v:true})
    endfunction

    call remote#host#Register('my_plugin', 'x', function('s:RequirePlugin'))
    call remote#host#RegisterPlugin('my_plugin', '0', [
        \ {'type': 'function', 'name': 'Plugtest', 'sync': 0, 'opts': {}},
        \ {'type': 'function', 'name': 'ScheduleTask', 'sync': 0, 'opts': {}},
        \ {'type': 'autocmd', 'name': 'VimEnter', 'sync': 0, 'opts': {'group': 'ExmplNvGoClientGrp', 'pattern': '*'}},
        \ ])

    ]]

    -- load rust(nvim-oxi) plugin
    local cdef = [[
    typedef struct {
        char* project;
        char* source;
        char* target;
        char* title;
        int remove_source;
    } create_mr_param;


    // methods
    void init();
    void schedule_task();
    void create_mr(create_mr_param);
    void approve_mr(create_mr_param);

    // debug methods
    int ping(int);
    void do_some_thing();
    typedef struct { char* s; } struct_type;
    void ffi_type_convert(int, char*, struct_type);
    ]]
    -- Example:
    --      lua vim.oxi.ffi_type_convert(10, require('ffi').new('char[?]', 3, "hello"))

    local ffi = require('ffi')
    ffi.cdef(cdef)
    local config_path = vim.fn.stdpath('config')
    vim.oxi = ffi.load(config_path .. "/rplugin/oxi/target/release/liboxi.dylib")
    vim.oxi.init()
end
return {
    setup = setup
}
