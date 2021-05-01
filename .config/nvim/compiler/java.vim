" Vim compiler file
" Compiler: java
" Maintainer: Karl


if exists("current_compiler")
  finish
endif
let current_compiler = "java"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=javac\ -g\ %
CompilerSet errorformat=%A%f:%l:\ %m,%-Z%p^,%-C%.%#
