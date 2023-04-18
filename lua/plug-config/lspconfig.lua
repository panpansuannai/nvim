local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[g', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']g', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  if require'utils.check'.checkPlug('lspsaga.nvim') then
      require('lspsaga').setup(require('plug-config.lspsaga'))
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr',
            '<cmd>Lspsaga lsp_finder<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',
            '<cmd>tab split | Lspsaga goto_definition<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d',
            '<cmd>Lspsaga peek_definition<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
            '<cmd>Lspsaga goto_definition<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'H',
            '<cmd>Lspsaga hover_doc<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',
            '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>la',
            '<cmd>Lspsaga code_action<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lf',
          '<cmd>lua vim.lsp.buf.format()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr',
            '<cmd>Lspsaga rename<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>li',
            '<cmd>Lspsaga incoming_calls<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lo',
            '<cmd>Lspsaga outcoming_calls<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>o',
            '<cmd>Lspsaga outline<CR>', opts)
  else
      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',
            '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD',
            '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd',
            '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'H',
            '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi',
            '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa',
            '<cmd>lua vim.lsp.buf.add_workleader_folder()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr',
            '<cmd>lua vim.lsp.buf.remove_workleader_folder()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl',
            '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workleader_folders()))<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt',
            '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca',
            '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lf',
            '<cmd>lua vim.lsp.buf.formatting({tabSize = 4})<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lr',
            '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>li',
            '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>lo',
            '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)
      vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ls',
            '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  end
end

-- Diagnostic
vim.diagnostic.config({
    update_in_insert = true,
    virtual_text = {
        prefix = ''
        }
})

-- language servier configs
require'lspconfig'.gopls.setup{
    single_file_support = true,
    on_attach = on_attach
}
-- require('go').setup()
require'lspconfig'.clangd.setup{}

require'lspconfig'.lua_ls.setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

vim.api.nvim_create_autocmd("BufWritePre", {
       buffer = buffer,
       callback = function()
           vim.lsp.buf.format { async = true}
       end
   })
--[[
sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
sign define DiagnosticSignHint text=💡 texthl=DiagnosticSignHint linehl= numhl=
--]]
