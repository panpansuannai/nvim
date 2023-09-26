require('telescope.builtin')

return {
    setup = function()
        --  vim.cmd[[highlight TelescopeNormal guibg=#2a2a2b]]
        local actions = require("telescope.actions")
        require('telescope').setup {
            defaults = {
                -- Default configuration for telescope goes here:
                -- config_key = value,
                path_display = {
                    -- smart = true,
                    truncate = 3,
                },
                file_ignore_patterns = {
                    "mock_.+%.go",
                    ".+_test.go",
                },
                mappings = {
                    i = {
                        -- map actions.which_key to <C-h> (default: <C-/>)
                        -- actions.which_key shows the mappings for your picker,
                        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
                        ["<esc>"] = actions.close,
                        ["<c-[>"] = actions.close,
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<C-D>"] = actions.results_scrolling_up,
                        ["<C-u>"] = false,
                        ["<C-f>"] = actions.preview_scrolling_down,
                        ["<C-b>"] = actions.preview_scrolling_up,
                        ["<C-o>"] = actions.file_edit,
                        ["<C-t>"] = actions.file_tab,
                        ["<C-l>"] = function(bufnr)
                            vim.notify("Add to loclist " .. vim.inspect(bufnr), vim.log.levels.INFO)
                            actions.send_selected_to_loclist(bufnr)
                        end,
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
    end
}
