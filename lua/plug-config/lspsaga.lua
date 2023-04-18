return {
    lightbulb = {
        enable = true,
        enable_in_insert = true,
        sign = true,
        sign_priority = 40,
        virtual_text = true,
    },
    outline = {
        win_position = "right",
        win_with = "",
        win_width = 50,
        preview_width = 0.4,
        show_detail = true,
        auto_preview = true,
        auto_refresh = true,
        auto_close = true,
        custo_sort = nil,
        keys = {
            expand_or_jump = 'o',
            quit = "q",
        },
    },
    code_action = {
        num_shortcut = true,
        show_server_name = false,
        extend_gitsigns = true,
        keys = {
            -- string | table type
            quit = "q",
            exec = "<CR>",
        },
    },
}
