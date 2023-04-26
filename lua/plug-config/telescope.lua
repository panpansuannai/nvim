local actions = require("telescope.actions")
require('telescope').setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<esc>"] = actions.close,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<c-[>"] = actions.close,
        ["<C-u>"] = false,
        ["<C-f>"] = actions.preview_scrolling_down,
        ["<C-b>"] = actions.preview_scrolling_up,
        ["<C-o>"] = actions.file_edit,
        ["<C-t>"] = actions.file_tab
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}
vim.keymap.set('n', '<leader>tf', function() require('telescope.builtin').find_files() end, { unique = true})
vim.keymap.set('n', '<leader>tg', function() require('telescope.builtin').live_grep() end, { unique = true})
vim.keymap.set('n', '<leader>tb', function() require('telescope.builtin').buffers() end, { unique = true})
vim.keymap.set('n', '<leader>tp', function() require('telescope.builtin').treesitter(
) end, { unique = true})
vim.keymap.set('n', '<leader>ty', function() require('telescope.builtin').current_buffer_fuzzy_find() end, { unique = true})
vim.keymap.set('n', '<leader>t', function() require('telescope.builtin').builtin() end, { unique = true})

-- LSP
vim.keymap.set('n', '<leader>gi', function() require('telescope.builtin').lsp_incoming_calls() end, { unique = true})
vim.keymap.set('n', '<leader>go', function() require('telescope.builtin').lsp_outgoing_calls() end, { unique = true})
vim.keymap.set('n', 'gr', function() require('telescope.builtin').lsp_references() end, { unique = true})
vim.keymap.set('n', 'gi', function() require('telescope.builtin').lsp_implementations() end, { unique = true})
vim.keymap.set('n', 'gd', function() require('telescope.builtin').lsp_definitions() end, {unique = true})
vim.keymap.set('n', 'gD', function() require('telescope.builtin').lsp_definitions({
    jump_type = "tab"
}) end, { unique = true})

vim.keymap.set('n', '<leader>db', function() require('telescope.builtin').diagnostics({
    bufnr = 0
}) end, { unique = true})
vim.keymap.set('n', '<leader>dw', function() require('telescope.builtin').diagnostics({
    bufnr = nil
}) end, { unique = true})
