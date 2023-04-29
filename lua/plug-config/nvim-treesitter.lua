require'nvim-treesitter.configs'.setup {
  ensure_installed = {'c', 'cpp','json', 'lua', 'go'},
  highlight = {
    enable = true,
    additional_vim_regex_highlight = false,
  },
  indent = {
    enable = true,
  },
  parser_install_dir = vim.fn.stdpath('config')
}
--[[
-- integrate with rainbow
require "nvim-treesitter.highlight"
local hlmap = vim.treesitter.highlighter.hl_map
hlmap.error = nil
hlmap["punctuation.delimiter"] = "Delimiter"
hlmap["punctuation.bracket"] = nil
--]]
