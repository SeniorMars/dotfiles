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
endfunction

augroup MyHighlights
  autocmd!
  autocmd ColorScheme * call MyHighlights()
augroup END
