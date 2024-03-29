return {
    setup = function()
        require('overseer').setup({
            strategy = "jobstart",
            templates = { "builtin" },
            form = {
                border = "rounded",
                zindex = 40,
                -- Dimensions can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
                -- min_X and max_X can be a single value or a list of mixed integer/float types.
                min_width = 80,
                max_width = 0.9,
                width = nil,
                min_height = 10,
                max_height = 0.9,
                height = nil,
                -- Set any window options here (e.g. winhighlight)
                win_opts = {
                    winblend = 0,
                },
            },
            task_list = {
                separator = '',
                bindings = {
                    ["?"] = "ShowHelp",
                    ["g?"] = "ShowHelp",
                    ["<CR>"] = "RunAction",
                    ["<C-e>"] = "Edit",
                    ["i"] = "Edit",
                    ["o"] = "Open",
                    ["<C-v>"] = "OpenVsplit",
                    ["<C-s>"] = "OpenSplit",
                    ["<C-f>"] = "OpenFloat",
                    ["<C-q>"] = "OpenQuickFix",
                    ["p"] = "TogglePreview",
                    ["["] = "DecreaseWidth",
                    ["]"] = "IncreaseWidth",
                    ["{"] = "PrevTask",
                    ["}"] = "NextTask",
                    ["<C-k>"] = "ScrollOutputUp",
                    ["<C-j>"] = "ScrollOutputDown",
                    ["<C-l>"] = false,
                    ["<C-h>"] = false,
                    ["L"] = false,
                    ["H"] = false,
                    ["q"] = "Close",
                    ["<Esc>"] = "Close",
                    ["<C-[>"] = "Close",
                },
            },
            -- Configuration for task floating windows
            task_win = {
                -- How much space to leave around the floating window
                padding = 2,
                border = "rounded",
                -- Set any window options here (e.g. winhighlight)
                win_opts = {
                    winblend = 10,
                },
            },
            task_launcher = {
                -- Set keymap to false to remove default behavior
                -- You can add custom keymaps here as well (anything vim.keymap.set accepts)
                bindings = {
                    i = {
                        ["<C-s>"] = "Submit",
                        ["<C-c>"] = "Cancel",
                        ["<C-j>"] = "Next",
                        ["<C-k>"] = "Prev",
                    },
                    n = {
                        ["<CR>"] = "Submit",
                        ["<C-s>"] = "Submit",
                        ["<Esc>"] = "Cancel",
                        ["<C-[>"] = "Cancel",
                        ["q"] = "Cancel",
                        ["?"] = "ShowHelp",
                    },
                },
            },
            task_editor = {
                -- Set keymap to false to remove default behavior
                -- You can add custom keymaps here as well (anything vim.keymap.set accepts)
                bindings = {
                    i = {
                        ["<CR>"] = "NextOrSubmit",
                        ["<C-j>"] = "Next",
                        ["<C-k>"] = "Prev",
                        ["<C-s>"] = "Submit",
                        ["<C-c>"] = "Cancel",
                    },
                    n = {
                        ["<CR>"] = "NextOrSubmit",
                        ["<C-s>"] = "Submit",
                        ["q"] = "Cancel",
                        ["<Esc>"] = "Cancel",
                        ["<C-[>"] = "Cancel",
                        ["?"] = "ShowHelp",
                    },
                },
            },
            log = {
                {
                    type = "echo",
                    level = vim.log.levels.WARN,
                },
            },
        })
        vim.cmd [[highlight OverseerTaskBorder guibg=NONE]]
        vim.cmd [[highlight OverseerTask guibg=NONE]]
        vim.cmd [[highlight OverseerOutput guibg=NONE]]
        require('config.overseer.templates').setup()
    end
}
