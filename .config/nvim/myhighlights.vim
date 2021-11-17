function! MyHighlights() abort
  " highlight CocCodeLens guifg=#7c6f64
  highlight CocCodeLens guifg=#878787
  highlight CocWarningFloat guifg=#dfaf87
  highlight GruvboxOrangeSign guifg=#dfaf87 guibg=#0E1018
  highlight GruvboxAquaSign guifg=#8EC07C guibg=#0E1018
  highlight GruvboxRedSign guifg=#fb4934 guibg=#0E1018
  highlight GruvboxBlueSign guifg=#83a598 guibg=#0E1018
  highlight CursorLineNr guifg=#fabd2f guibg=#0E1018
  highlight SignColumn guifg=#0E1018 guibg=#10151a
  highlight StatusLine guibg=#ffffff guifg=#0E1018
  highlight StatusLineNC guibg=#3c3836 guifg=#0E1018
  highlight CocRustTypeHint guifg=#87afaf guibg=#0E1018
  highlight CocRustChainingHint guifg=#87afaf guibg=#0E1018
  highlight Folded gui=italic guifg=#fe8019 guibg=#3c3836
  highlight FoldColumn guifg=#fe8019 guibg=#0E1018
  highlight Comment gui=italic guifg=#fe8019
  highlight! link TSAnnotation GruvboxAqua
  highlight! link TSBoolean GruvboxPurple
  highlight! link TSCharacter GruvboxPurple
  highlight! link TSConstructor GruvboxOrange
  highlight! link TSConditional GruvboxRed
  highlight! link TSConstant GruvboxPurple
  highlight! link TSConstBuiltin GruvboxPurple
  highlight! link TSConstMacro GruvboxPurple
  highlight! link TSError GruvboxRed
  highlight! link TSException GruvboxRed
  highlight! link TSField GruvboxBlue
  highlight! link TSFloat GruvboxPurple
  highlight! link TSFunction GruvboxGreenBold
  highlight! link TSFuncBuiltin GruvboxOrange
  highlight! link TSFuncMacro GruvboxAqua
  highlight! link TSInclude GruvboxAqua
  highlight! link TSKeyword GruvboxRed
  highlight! link TSLabel GruvboxRed
  highlight! link TSMethod GruvboxGreenBold
  highlight! link TSNamespace GruvboxAqua
  highlight! link TSNone GruvboxPurple
  highlight! link TSNumber GruvboxPurple
  highlight! link TSOperator GruvboxOrange
  highlight! link TSParamter GruvboxFg
  highlight! link TSParameterReferance GruvboxFg
  highlight! link TSProperty GruvboxBlue
  highlight! link TSPunctDelimiter GruvboxOrange
  highlight! link TSPunctBracket GruvboxOrange
  highlight! link TSPunctSpecial GruvboxFg
  highlight! link TSRepeat GruvboxRed
  highlight! link TSString GruvboxGreen
  highlight! link TSStringRegex GruvboxYellow
  highlight! link TSStringEscape GruvboxOrange
  highlight! link TSTagDelimiter GruvboxAqua
  highlight! link TSText GruvboxFg
  highlight! link TSLiteral GruvboxFg
  highlight! link TSURI GruvboxYellow
  highlight! link TSType GruvboxYellow
  highlight! link TSTypeBuiltin GruvboxYellow
  highlight! link TSVariable GruvboxFg
  highlight! TSEmphasis cterm=italic
  highlight! TSUnderline cterm=underline
endfunction

augroup MyHighlights
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END
