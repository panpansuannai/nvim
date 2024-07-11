-- helper function to notify response of LSP server
local loading_icons = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
local records = {}
local function notify_lsp_progress(method)
    local old_handler = vim.lsp.handlers[method]
    if old_handler ~= nil then
        vim.lsp.handlers[method] = function(...)
            local arg = { ... }
            local result = arg[2]
            if result.value == nil or result.value.message == nil then
                return
            end
            local last = records[result.token]
            local last_record = nil
            local cnt = 1
            if last ~= nil then
                last_record = last[1]
                cnt = last[2]
            end
            records[result.token] = { vim.notify(result.value.message, vim.log.levels.INFO, {
                title = "LSP progress",
                replace = last_record,
                icon = loading_icons[cnt % 9 + 1],
            }), cnt + 1 }
            old_handler(...)
        end
    end
end

--[[
local function hover_when_hold()
    -- hover current word
    local function cursor_hold_callback(bufnr, ev)
        local pos = vim.lsp.util.make_position_params()
        vim.lsp.buf_request(bufnr, 'textDocument/hover', pos, function(_, result, ctx, config)
            if result ~= nil and result.contents ~= nil then
                if vim.lsp.util.make_position_params().position.line ~= pos.position.line then
                    return
                end
                vim.notify("", vim.lsp.log_levels.INFO, {
                    title = 'Hover',
                    onopen = function(win)
                        vim.api.nvim_win_set_option(win, 'wrap', true)
                    end,
                    render = function(buf, _)
                        local md_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
                        vim.api.nvim_buf_set_lines(buf, 0, -1, false, md_lines)
                        vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
                    end
                })
            end
        end)
    end
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = bufnr,
        callback = function(ev)
            return cursor_hold_callback(bufnr, ev)
        end
    })
end
]]
--

return {
    setup = function()
        -- debug lsp
        -- notify_lsp_handler('textDocument/hover')
        --[[ use noice to tell the progress
         notify_lsp_progress('$/progress')
         ]]
        -- Diagnostic
        vim.cmd [[sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=]]
        vim.cmd [[sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=]]
        vim.cmd [[sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=]]
        vim.cmd [[sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=]]

        vim.diagnostic.config({
            float = {},
            update_in_insert = true,
            virtual_text = {
                prefix = '',
                source = false,
            }
        })

        local on_attach = function(client, bufnr)
            -- Format on save.
            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format { async = true }
                end
            })
            --
        end

        -- language servier configs
        require 'lspconfig'.rust_analyzer.setup {
            on_attach = on_attach,
        }

        -- gopls
        require 'lspconfig'.gopls.setup {
            single_file_support = true,
            on_attach = on_attach,
        }

        -- clangd
        require 'lspconfig'.clangd.setup {
            single_file_support = true,
            on_attach = function(client, bufnr)
                --vim.bo.softtabstop = 2
                on_attach(client, bufnr)
            end,
        }

        -- python
        require 'lspconfig'.pyright.setup {}

        -- thriftls
        require 'lspconfig'.thriftls.setup {}

        -- json
        require 'lspconfig'.jsonls.setup {}

        -- js
        --require'lspconfig'.dprint.setup{}
        -- require 'lspconfig'.ember.setup {}
        require 'lspconfig'.tsserver.setup {
            init_options = {
                --[[
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
                        languages = { "javascript", "typescript", "vue" },
                    },
                },
                ]]
            },
            filetypes = {
                "javascript",
                "typescript",
            },
        }


        -- lua_ls
        require 'lspconfig'.lua_ls.setup {
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
                    return
                end

                client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
                    runtime = {
                        -- Tell the language server which version of Lua you're using
                        -- (most likely LuaJIT in the case of Neovim)
                        version = 'LuaJIT'
                    },
                    -- Make the server aware of Neovim runtime files
                    workspace = {
                        checkThirdParty = false,
                        library = {
                            vim.env.VIMRUNTIME
                            -- Depending on the usage, you might want to add additional paths here.
                            -- "${3rd}/luv/library"
                            -- "${3rd}/busted/library",
                        }
                        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
                        -- library = vim.api.nvim_get_runtime_file("", true)
                    }
                })
            end,
            settings = {
                Lua = {}
            }
        }
    end
}
