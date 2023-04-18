local gl = require('galaxyline')
local provider = require('galaxyline.provider')
local diagnostic = require('galaxyline.provider_diagnostic')
local extensions = require('galaxyline.provider_extensions')
local diagnostic = require('galaxyline.provider_diagnostic')
local fileInfo = require('galaxyline.provider_fileinfo')
-- get my theme in galaxyline repo
-- local colors = require('galaxyline.theme').default
local colors = {
    -- bg = '#2E2E2E',
    bg = '#292D38',
    yellow = '#DCDCAA',
    dark_yellow = '#D7BA7D',
    cyan = '#4EC9B0',
    green = '#608B4E',
    light_green = '#B5CEA8',
    string_orange = '#CE9178',
    orange = '#FF8800',
    purple = '#C586C0',
    magenta = '#D16D9E',
    grey = '#858585',
    blue = '#569CD6',
    vivid_blue = '#4FC1FF',
    light_blue = '#9CDCFE',
    red = '#D16969',
    error_red = '#F44747',
    info_yellow = '#FFCC66'
}
local mode_color = {
    n = colors.red,
    i = colors.green,
    v = colors.blue,
        [''] = colors.blue,
    V = colors.blue,
    c = colors.magenta,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
        [''] = colors.orange,
    ic = colors.yellow,
    R = colors.purple,
    Rv = colors.purple,
    Rc = colors.purple,
    Rx = colors.purple,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!'] = colors.red,
    t = colors.red
}

local mode_icon = {
    c = "🅒 ",
        ['!'] = "🅒 ",
    i = "🅘 ",
    ic = "🅘 ",
    ix = "🅘 ",
    n = "🅝 ",
    R = "🅡 ",
    Rv = "🅡 ",
    r = "🅡 ",
    rm = "🅡 ",
        ['r?'] = "🅡 ",
    s = "🅢 ",
    S = "🅢 ",
        [''] = "🅢 ",
    t = "🅣 ",
    v = "🅥 ",
    V = "🅥 ",
        [''] = "🅥 ",
}

--[[
local function mode_alias(m)
  local alias = {
    n = 'NORMAL',
    i = 'INSERT',
    c = 'COMMAND',
    R = 'REPLACE',
    t = 'TERMINAL',
    [''] = 'V-BLOCK',
    V = 'V-LINE',
    v = 'VISUAL',
  }
  return alias[m]
end
]]
--

local condition = require('galaxyline.condition')
local gls = gl.section
gl.short_line_list = { 'NvimTree', 'vista', 'dbui', 'packer' }
--[[
table.insert(gls.left, {
    Start = {
      provider = function()
            local mode_string = '▊ '
            vim.api.nvim_command('hi GalaxyStart guifg=' .. mode_color[vim.fn.mode()])
            if vim.bo.modified
            then
              mode_string = mode_string..'  '
            else
              mode_string = mode_string..' '
            end
            return mode_string
      end,
      highlight = {mode_color[vim.fn.mode() or vim.fn.visualmode()], colors.bg}
    }
})
--]]
table.insert(gls.left, {
    ViMode = {
        -- separator = ' ',
        separator_highlight = 'GalaxyViModeReverse',
        provider = function()
            -- auto change color according the vim mode
            local mode = vim.fn.mode() or vim.fn.visualmode()
            if (mode_color[mode])
            then
                vim.api.nvim_command('hi GalaxyViMode guifg=' .. mode_color[mode])
                vim.api.nvim_command('hi GalaxyViModeReverse guifg=' .. mode_color[mode])
            end
            local mode_string = '▊ ' .. mode
            -- mode_string = mode_string .. mode_icon[mode]
            -- mode_string = 'N'
            return mode_string .. " "
        end,
        highlight = { colors.red, colors.bg, 'bold' }
    }
})

table.insert(gls.left, {
    GitIcon = {
        provider = function()
            return '   '
        end,
        condition = condition.check_git_workspace,
        --separator = ' ',
        separator_highlight = { 'NONE', colors.bg },
        highlight = { colors.bg, colors.dark_yellow, 'bold' }
    }
})

table.insert(gls.left, {
    GitBranch = {
        provider = 'GitBranch',
        ondition = condition.check_git_workspace,
        separator = '    ',
        separator_highlight = { 'NONE', colors.bg },
        highlight = { colors.bg, colors.dark_yellow, 'bold' }
    }
})

table.insert(gls.left, {
    DiffAdd = {
        provider = 'DiffAdd',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = { colors.green, colors.bg }
    }
})
table.insert(gls.left, {
    DiffModified = {
        provider = 'DiffModified',
        condition = condition.hide_in_width,
        icon = ' 柳',
        highlight = { colors.blue, colors.bg }
    }
})
table.insert(gls.left, {
    DiffRemove = {
        provider = 'DiffRemove',
        condition = condition.hide_in_width,
        icon = '  ',
        highlight = { colors.red, colors.bg }
    }
})

table.insert(gls.right, {
    DiagnosticError = {
        provider = 'DiagnosticError', icon = '  ', highlight = { colors.error_red, colors.bg }
    }
})

table.insert(gls.right, {
    DiagnosticHint = {
        provider = 'DiagnosticHint', icon = '  ', highlight = { colors.vivid_blue, colors.bg }
    }
})
table.insert(gls.right, {
    DiagnosticWarn = {
        provider = 'DiagnosticWarn', icon = ' ⚠ ', highlight = { colors.orange, colors.bg }
    }
})

table.insert(gls.right, {
    FileIcon = {
        provider = fileInfo.get_file_icon,
        -- condition = condition.buffer_not_empty,
        highlight = { fileInfo.get_file_icon_color(), colors.bg }
    }
})

table.insert(gls.right, {
    FileName = {
        provider = fileInfo.get_current_file_name,
        -- condition = condition.buffer_not_empty,
        highlight = { colors.yellow, colors.bg, 'bold' }
    }
})


--[[
  })
--]]
table.insert(gls.right, {
    TreesitterIcon = {
        provider = function()
            if next(vim.treesitter.highlighter.active) ~= nil then return ' ' end
            return ''
        end,
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg },
        highlight = { colors.green, colors.bg }
    }
})

table.insert(gls.right, {
    Lsp = {
        provider = function()
            return '「'..vim.lsp.buf_get_clients()[1].name..'」'
        end,
        condition = function()
            return vim.tbl_count(vim.lsp.buf_get_clients()) > 0
        end,
        -- seperator = " ",
        highlight = { colors.purple, colors.bg , 'bold'}
    }
})


table.insert(gls.right, {
    LineInfo = {
        provider = 'LineColumn',
        -- separator = ' ',
        separator_highlight = { 'NONE', colors.bg },
        highlight = { colors.purple, colors.bg }
    }
})

table.insert(gls.right, {
    PerCent = {
        provider = 'LinePercent',
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg },
        highlight = { colors.bg, colors.vivid_blue }
    }
})

table.insert(gls.right, {
    Tabstop = {
        provider = function()
            return "Spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth") .. " "
        end,
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg },
        highlight = { colors.grey, colors.bg }
    }
})

table.insert(gls.right, {
    BufferType = {
        provider = 'FileTypeName',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg },
        highlight = { colors.cyan, colors.bg }
    }
})

table.insert(gls.right, {
    FileEncode = {
        provider = 'FileEncode',
        condition = condition.hide_in_width,
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg },
        highlight = { colors.blue, colors.bg }
    }
})

table.insert(gls.right, {
    Space = {
        provider = function()
            return ' '
        end,
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg },
        highlight = { colors.orange, colors.bg }
    }
})

table.insert(gls.short_line_left, {
    BufferType = {
        provider = 'FileTypeName',
        separator = ' ',
        separator_highlight = { 'NONE', colors.bg },
        highlight = { colors.grey, colors.bg }
    }
})

table.insert(gls.short_line_left, {
    SFileName = { provider = 'SFileName', condition = condition.buffer_not_empty, highlight = { colors.blue, colors.bg } }
})
--[[
table.insert(gls.right, {
  ViMode = {
    icon = ' ',
    separator = ' ',
    separator_highlight = 'GalaxyViModeReverse',
    highlight = {colors.bg, mode_color['n']},
    provider = function()
      local m = vim.fn.mode() or vim.fn.visualmode()
      local mode = mode_alias(m)
      local color = mode_color[m]
      vim.api.nvim_command('hi GalaxyViMode guibg=' .. color)
      vim.api.nvim_command('hi GalaxyViModeReverse guifg=' .. color)
      return ' ' .. mode .. ' '
    end,
  }
})
--]]
--table.insert(gls.short_line_right[1] = {BufferIcon = {provider = 'BufferIcon', highlight = {colors.grey, colors.bg}}})
