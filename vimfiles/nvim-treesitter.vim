lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = {'c', 'cpp','json', 'lua', 'python', 'bash'},
  highlight = {
    enable = true,
  }
}
-- integrate with rainbow
require "nvim-treesitter.highlight"
local hlmap = vim.treesitter.highlighter.hl_map
hlmap.error = nil
hlmap["punctuation.delimiter"] = "Delimiter"
hlmap["punctuation.bracket"] = nil
EOF
