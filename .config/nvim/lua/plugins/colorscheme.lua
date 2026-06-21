return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
                palette_overrides = {dark0_hard = "#0E1018"},
                overrides = {
                    NormalFloat = {fg = "#ebdbb2", bg = "#504945"},
                    Comment = {fg = "#81878f", italic = true, bold = true},
                    Define = {link = "GruvboxPurple"},
                    Macro = {link = "GruvboxPurple"},
                    ["@constant.builtin"] = {link = "GruvboxPurple"},
                    ["@storageclass.lifetime"] = {link = "GruvboxAqua"},
                    ["@text.note"] = {link = "TODO"},
                    ["@namespace.rust"] = {link = "Include"},
                    ["@punctuation.bracket"] = {link = "GruvboxOrange"},
                    texMathDelimZoneLI = {link = "GruvboxOrange"},
                    texMathDelimZoneLD = {link = "GruvboxOrange"},
                    luaParenError = {link = "luaParen"},
                    luaError = {link = "NONE"},
                    ContextVt = {fg = "#878788"},
                    CopilotSuggestion = {fg = "#878787"},
                    CocCodeLens = {fg = "#878787"},
                    CocWarningFloat = {fg = "#dfaf87"},
                    CocInlayHint = {fg = "#ABB0B6"},
                    CocPumShortcut = {fg = "#fe8019"},
                    CocPumDetail = {fg = "#fe8019"},
                    DiagnosticVirtualTextWarn = {fg = "#dfaf87"},
                    -- fold
                    Folded = {fg = "#fe8019", bg = "#0E1018", italic = true},
                    SignColumn = {bg = "#fe8019"},
                    -- new git colors
                    DiffAdd = {
                        bold = true,
                        reverse = false,
                        fg = "",
                        bg = "#2a4333"
                    },
                    DiffChange = {
                        bold = true,
                        reverse = false,
                        fg = "",
                        bg = "#333841"
                    },
                    DiffDelete = {
                        bold = true,
                        reverse = false,
                        fg = "#442d30",
                        bg = "#442d30"
                    },
                    DiffText = {
                        bold = true,
                        reverse = false,
                        fg = "",
                        bg = "#213352"
                    },
                    -- statusline
                    StatusLine = {fg = "#ffffff", bg = "#0E1018"},
                    StatusLineNC = {fg = "#3c3836", bg = "#0E1018"},
                    CursorLineNr = {fg = "#fabd2f", bg = ""},
                    GruvboxOrangeSign = {fg = "#dfaf87", bg = "#0E1018"},
                    GruvboxAquaSign = {fg = "#8EC07C", bg = "#0E1018"},
                    GruvboxGreenSign = {fg = "#b8bb26", bg = "#0E1018"},
                    GruvboxRedSign = {fg = "#fb4934", bg = "#0E1018"},
                    GruvboxBlueSign = {fg = "#83a598", bg = "#0E1018"},
                    WilderMenu = {fg = "#ebdbb2", bg = ""},
                    WilderAccent = {fg = "#f4468f", bg = ""},
                    -- coc semantic token
                    CocSemStruct = {link = "GruvboxYellow"},
                    CocSemKeyword = {fg = "", bg = "#0E1018"},
                    CocSemEnumMember = {fg = "", bg = "#0E1018"},
                    CocSemTypeParameter = {fg = "", bg = "#0E1018"},
                    CocSemComment = {fg = "", bg = "#0E1018"},
                    CocSemMacro = {fg = "", bg = "#0E1018"},
                    CocSemVariable = {fg = "", bg = "#0E1018"},
                    CocSemFunction = {fg = "", bg = "#0E1018"},
                    SnacksPicker = {fg = "#ebdbb2", bg = "#0E1018"},
                    SnacksPickerBorder = {fg = "#ebdbb2", bg = "#0E1018"},
                    SnacksPickerBoxBorder = {fg = "#ebdbb2", bg = "#0E1018"},
                    SnacksNormal = {fg = "#ebdbb2", bg = "#0E1018"},
                    SnacksPickerDir = {link = "GruvboxGreen"},
                    SnacksImageMath = {link = "GruvboxGreen"},
                    RenderMarkdownH1Bg = {bold = true, bg = "#213352"},
                    RenderMarkdownH2Bg = {bold = true, bg = "#2a4333"},
                    RenderMarkdownH3Bg = {bold = true, bg = "#333841"},
                    RenderMarkdownH4Bg = {bold = true, bg = "#442d30"},
                    RenderMarkdownH5Bg = {bold = true, bg = "#504945"},
                    RenderMarkdownH6Bg = {bold = true, bg = "#504945"},
                    RenderMarkdownSign = {bg = "#0E1018"},
                    -- neorg
                    ["@neorg.markup.inline_macro"] = {link = "GruvboxGreen"}
                }
            })

            vim.cmd.colorscheme("gruvbox")
        end
    }
}
