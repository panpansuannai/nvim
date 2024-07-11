local M = {}

M.setup = function()
    require('kanagawa').setup({
        compile = false,  -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = true,    -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {
            -- add/modify theme and palette colors
            palette = {
                ["contrastBorder"] = "#282B3C",
                ["focusBorder"] = "#282B3C",
                ["foreground"] = "#ffffff",
                ["widget.shadow"] = "#232635",
                ["selection.background"] = "#7580B850",
                ["errorForeground"] = "#EF5350",
                ["button.background"] = "#7e57c2cc",
                ["button.foreground"] = "#ffffffcc",
                ["button.hoverBackground"] = "#7e57c2",
                ["dropdown.background"] = "#292D3E",
                ["dropdown.border"] = "#7e57c2",
                ["dropdown.foreground"] = "#ffffffcc",
                ["input.background"] = "#313850",
                ["input.border"] = "#7e57c2",
                ["input.foreground"] = "#ffffffcc",
                ["input.placeholderForeground"] = "#ffffffcc",
                ["inputOption.activeBorder"] = "#ffffffcc",
                ["inputValidation.errorBackground"] = "#ef5350f2",
                ["inputValidation.errorBorder"] = "#EF5350",
                ["inputValidation.infoBackground"] = "#64b5f6f2",
                ["inputValidation.infoBorder"] = "#64B5F6",
                ["inputValidation.warningBackground"] = "#ffca28f2",
                ["inputValidation.warningBorder"] = "#FFCA28",
                ["scrollbar.shadow"] = "#292D3E00",
                ["scrollbarSlider.activeBackground"] = "#694CA4cc",
                ["scrollbarSlider.background"] = "#694CA466",
                ["scrollbarSlider.hoverBackground"] = "#694CA4cc",
                ["badge.background"] = "#7e57c2",
                ["badge.foreground"] = "#ffffff",
                ["progress.background"] = "#7e57c2",
                ["list.activeSelectionBackground"] = "#7e57c2",
                ["list.activeSelectionForeground"] = "#ffffff",
                ["list.dropBackground"] = "#2E3245",
                ["list.focusBackground"] = "#0000002e",
                ["list.focusForeground"] = "#ffffff",
                ["list.highlightForeground"] = "#ffffff",
                ["list.hoverBackground"] = "#0000001a",
                ["list.hoverForeground"] = "#ffffff",
                ["list.inactiveSelectionBackground"] = "#929ac90d",
                ["list.inactiveSelectionForeground"] = "#929ac9",
                ["activityBar.background"] = "#282C3D",
                ["activityBar.dropBackground"] = "#7e57c2e3",
                ["activityBar.foreground"] = "#eeffff",
                ["activityBar.border"] = "#282C3D",
                ["activityBarBadge.background"] = "#7e57c2",
                ["activityBarBadge.foreground"] = "#ffffff",
                ["sideBar.background"] = "#292D3E",
                ["sideBar.foreground"] = "#6C739A",
                ["sideBar.border"] = "#282B3C",
                ["sideBarTitle.foreground"] = "#eeffff",
                ["sideBarSectionHeader.background"] = "#292D3E",
                ["sideBarSectionHeader.foreground"] = "#eeffff",
                ["editorGroup.background"] = "#32374C",
                ["editorGroup.border"] = "#2E3245",
                ["editorGroup.dropBackground"] = "#7e57c273",
                ["editorGroupHeader.noTabsBackground"] = "#32374C",
                ["editorGroupHeader.tabsBackground"] = "#31364a",
                ["editorGroupHeader.tabsBorder"] = "#262A39",
                ["tab.activeBackground"] = "#292D3E",
                ["tab.activeForeground"] = "#eeffff",
                ["tab.border"] = "#272B3B",
                ["tab.activeBorder"] = "#262A39",
                ["tab.unfocusedActiveBorder"] = "#262A39",
                ["tab.inactiveBackground"] = "#31364A",
                ["tab.inactiveForeground"] = "#929ac9",
                ["editor.background"] = "#292D3E",
                ["editor.foreground"] = "#BFC7D5",
                ["editorLineNumber.foreground"] = "#4c5374",
                ["editorLineNumber.activeForeground"] = "#eeffff",
                ["editorCursor.foreground"] = "#7e57c2",
                ["editor.selectionBackground"] = "#7580B850",
                ["editor.selectionHighlightBackground"] = "#383D51",
                ["editor.inactiveSelectionBackground"] = "#7e57c25a",
                ["editor.wordHighlightBackground"] = "#32374D",
                ["editor.wordHighlightStrongBackground"] = "#2E3250",
                ["editor.findMatchBackground"] = "#2e3248fc",
                ["editor.findMatchHighlightBackground"] = "#7e57c233",
                ["editor.hoverHighlightBackground"] = "#7e57c25a",
                ["editor.lineHighlightBackground"] = "#0003",
                ["editor.rangeHighlightBackground"] = "#7e57c25a",
                ["editorIndentGuide.background"] = "#4E557980",
                ["editorRuler.foreground"] = "#4E557980",
                ["editorCodeLens.foreground"] = "#FFCA28",
                ["editorOverviewRuler.currentContentForeground"] = "#7e57c2",
                ["editorOverviewRuler.incomingContentForeground"] = "#7e57c2",
                ["editorOverviewRuler.commonContentForeground"] = "#7e57c2",
                ["editorError.foreground"] = "#EF5350",
                ["editorWarning.foreground"] = "#FFCA28",
                ["editorGutter.modifiedBackground"] = "#e2b93d",
                ["editorGutter.addedBackground"] = "#9CCC65",
                ["editorGutter.deletedBackground"] = "#EF5350",
                ["diffEditor.insertedTextBackground"] = "#99b76d23",
                ["diffEditor.removedTextBackground"] = "#ef535033",
                ["editorWidget.background"] = "#31364a",
                ["editorSuggestWidget.background"] = "#2C3043",
                ["editorSuggestWidget.border"] = "#2B2F40",
                ["editorSuggestWidget.foreground"] = "#bfc7d5",
                ["editorSuggestWidget.highlightForeground"] = "#ffffff",
                ["editorSuggestWidget.selectedBackground"] = "#7e57c2",
                ["editorHoverWidget.background"] = "#292D3E",
                ["editorHoverWidget.border"] = "#7e57c2",
                ["debugExceptionWidget.background"] = "#292D3E",
                ["debugExceptionWidget.border"] = "#7e57c2",
                ["editorMarkerNavigation.background"] = "#31364a",
                ["editorMarkerNavigationError.background"] = "#EF5350",
                ["editorMarkerNavigationWarning.background"] = "#FFCA28",
                ["peekView.border"] = "#7e57c2",
                ["peekViewEditor.background"] = "#232635",
                ["peekViewEditor.matchHighlightBackground"] = "#7e57c25a",
                ["peekViewResult.background"] = "#2E3245",
                ["peekViewResult.fileForeground"] = "#eeffff",
                ["peekViewResult.lineForeground"] = "#eeffff",
                ["peekViewResult.matchHighlightBackground"] = "#7e57c25a",
                ["peekViewResult.selectionBackground"] = "#2E3250",
                ["peekViewResult.selectionForeground"] = "#eeffff",
                ["peekViewTitle.background"] = "#292D3E",
                ["peekViewTitleDescription.foreground"] = "#697098",
                ["peekViewTitleLabel.foreground"] = "#eeffff",
                ["merge.currentHeaderBackground"] = "#7e57c25a",
                ["merge.incomingHeaderBackground"] = "#7e57c25a",
                ["merge.border"] = null,
                ["panel.background"] = "#292D3E",
                ["panel.border"] = "#282B3C",
                ["panelTitle.activeBorder"] = "#7e57c2",
                ["panelTitle.activeForeground"] = "#eeffff",
                ["panelTitle.inactiveForeground"] = "#bfc7d580",
                ["statusBar.background"] = "#282C3D",
                ["statusBar.foreground"] = "#676E95",
                ["statusBar.border"] = "#262A39",
                ["statusBar.debuggingBackground"] = "#202431",
                ["statusBar.debuggingBorder"] = "#1F2330",
                ["statusBar.noFolderBackground"] = "#292D3E",
                ["statusBar.noFolderBorder"] = "#25293A",
                ["statusBarItem.activeBackground"] = "#202431",
                ["statusBarItem.hoverBackground"] = "#202431",
                ["statusBarItem.prominentBackground"] = "#202431",
                ["statusBarItem.prominentHoverBackground"] = "#202431",
                ["titleBar.activeBackground"] = "#292d3e",
                ["titleBar.activeForeground"] = "#eeefff",
                ["titleBar.border"] = "#30364c",
                ["titleBar.inactiveBackground"] = "#30364c",
                ["notifications.background"] = "#292D3E",
                ["notifications.foreground"] = "#ffffffcc",
                ["notificationLink.foreground"] = "#80CBC4",
                ["extensionButton.prominentForeground"] = "#ffffffcc",
                ["extensionButton.prominentBackground"] = "#7e57c2cc",
                ["extensionButton.prominentHoverBackground"] = "#7e57c2",
                ["pickerGroup.foreground"] = "#d1aaff",
                ["pickerGroup.border"] = "#2E3245",
                ["terminal.ansiWhite"] = "#ffffff",
                ["terminal.ansiBlack"] = "#676E95",
                ["terminal.ansiBlue"] = "#82AAFF",
                ["terminal.ansiCyan"] = "#89DDFF",
                ["terminal.ansiGreen"] = "#a9c77d",
                ["terminal.ansiMagenta"] = "#C792EA",
                ["terminal.ansiRed"] = "#ff5572",
                ["terminal.ansiYellow"] = "#FFCB6B",
                ["terminal.ansiBrightWhite"] = "#ffffff",
                ["terminal.ansiBrightBlack"] = "#676E95",
                ["terminal.ansiBrightBlue"] = "#82AAFF",
                ["terminal.ansiBrightCyan"] = "#89DDFF",
                ["terminal.ansiBrightGreen"] = "#C3E88D",
                ["terminal.ansiBrightMagenta"] = "#C792EA",
                ["terminal.ansiBrightRed"] = "#ff5572",
                ["terminal.ansiBrightYellow"] = "#FFCB6B",
                ["debugToolBar.background"] = "#292D3E",
                ["walkThrough.embeddedEditorBackground"] = "#232635",
                ["gitDecoration.modifiedResourceForeground"] = "#e2c08de6",
                ["gitDecoration.deletedResourceForeground"] = "#EF535090",
                ["gitDecoration.untrackedResourceForeground"] = "#a9c77dff",
                ["gitDecoration.ignoredResourceForeground"] = "#69709890",
                ["gitDecoration.conflictingResourceForeground"] = "#FFEB95CC",
                ["editorActiveLineNumber.foreground"] = "#eeffff",
                ["breadcrumb.foreground"] = "#6c739a",
                ["breadcrumb.focusForeground"] = "#bfc7d5",
                ["breadcrumb.activeSelectionForeground"] = "#eeffff",
                ["breadcrumbPicker.background"] = "#292D3E",
                ["variable"] = "#ffcb6b",
                ["string"] = "#C3E88D",
                ["method"] = "#82AAFF",
                ["property"] = "#c792ea",
                ["parameter"] = "#7986E7",
            },
            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
            return {
                String = { fg = colors.palette.string, italic = true },
                ["@variable"] = { fg = colors.palette.variable },
                ["@method"] = { fg = colors.palette.method },
                ["@property"] = { fg = colors.palette.property },
                ["@field"] = { fg = colors.palette.lightBlue },
                ["@function.call"] = { fg = colors.palette.lotusRed, bold = true },
                ["@method.call"] = { fg = colors.palette.lotusRed, bold = true },
                ["@namespace"] = { fg = colors.palette.springGreen },
                ["@parameter"] = { fg = colors.palette.surimiOrange },
                ["@keyword"] = { fg = colors.palette.dragonPink },
                ["@conditional"] = { fg = colors.palette.dragonPink },
                ["@repeat"] = { fg = colors.palette.dragonPink },
                ["@operator"] = { fg = colors.palette.crystalBlue },
            }
        end,
        theme = "wave", -- Load "wave" theme when 'background' option is not set
        background = {
            -- map the value of 'background' option to a theme
            dark = "wave", -- try "dragon" !
            light = "lotus"
        },
    })

    -- setup must be called before loading
    vim.cmd("colorscheme kanagawa")
end
return M