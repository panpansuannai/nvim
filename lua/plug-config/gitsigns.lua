require('gitsigns').setup {
  signs = {
    add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
  yadm = {
    enable = false
  },
}
vim.keymap.set('n', '<leader>gp', '<cmd>Gitsigns preview_hunk<cr>', { unique = true})
vim.keymap.set('n', '<leader>gk', '<cmd>Gitsigns prev_hunk<cr>', { unique = true})
vim.keymap.set('n', '<leader>gj', '<cmd>Gitsigns next_hunk<cr>', { unique = true})
vim.keymap.set('n', '<leader>gd', '<cmd>Gitsigns diffthis<cr>', { unique = true})
vim.keymap.set('n', '<leader>gl', '<cmd>Gitsigns setqflist<cr>', { unique = true})
vim.keymap.set('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<cr>', { unique = true})
vim.keymap.set('n', '<leader>gs', '<cmd>Gitsigns stage_hunk<cr>', { unique = true})
vim.keymap.set('n', '<leader>gS', '<cmd>Gitsigns stage_buffer<cr>', { unique = true})
vim.keymap.set('n', '<leader>gu', '<cmd>Gitsigns reset_hunk<cr>', { unique = true})
vim.keymap.set('n', '<leader>g<space>', '<cmd>Gitsigns select_hunk<cr>', { unique = true})
