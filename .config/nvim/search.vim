function! WebSearch(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    silent exe "normal! `<" . a:type . "`>y"
  elseif a:type == 'line'
    silent exe "normal! '[V']y"
  elseif a:type == 'block'
    silent exe "normal! `[\<C-V>`]y"
  else
    silent exe "normal! `[v`]y"
  endif

  let search = substitute(trim(@@), ' \+', '+', 'g')
  silent exe "!firefox --new-tab 'https://duckduckgo.com/?q=" . search . "'"

  let &selection = sel_save
  let @@ = reg_save

endfunction
nmap <silent> gs :set opfunc=WebSearch<CR>g@
vmap <silent> gs :<C-u>call WebSearch(visualmode(), 1)<Cr>


if has("patch-8.1.0360")
    set diffopt+=internal,algorithm:patience
endif
