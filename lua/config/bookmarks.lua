return {
    setup = function()
        vim.cmd('highlight link BookmarkSign CursorLineNr')
        vim.cmd('highlight link BookmarkAnnotationSign CursorLineNr')
        vim.cmd('highlight link BookmarkLine CursorLine')
        vim.cmd('highlight link BookmarkAnnotationLine CursorLine')
        vim.g['bookmark_no_default_key_mappings'] = 0
        vim.g['bookmark_sign'] = '➤'
        -- vim.g['bookmark_annotation_sign'] = ''
        vim.g['bookmark_annotation_sign'] = '➤'
        vim.g['bookmark_save_per_working_dir'] = 1
        vim.g['bookmark_show_toggle_warning'] = 0
        vim.g['bookmark_auto_save'] = 1
        vim.g['bookmark_manage_per_buffer'] = 1
        -- vim.g['bookmark_auto_save_file'] = "$HOME/.config/nvim/bookmarks"
        vim.g['bookmark_auto_close'] = 1
        vim.g['bookmark_highlight_lines'] = 1
        vim.g['bookmark_display_annotation'] = 1
    end
}
