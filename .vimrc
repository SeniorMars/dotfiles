" I Moved to neovim, this is for the sake if I ever need vim again. See
" ~/.config/nvim for more

"Auto Download
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'jiangmiao/auto-pairs' "auto completes [] and () and makes life a bit easier
Plug 'tpope/vim-commentary' "Comment stuff
Plug 'tpope/vim-surround' "Allows me to change { to [ and what not
Plug 'wellle/targets.vim' "adds more targets like [ or , - lazy but useful 
Plug 'junegunn/fzf.vim'
call plug#end()

"Global options
filetype plugin indent on
syntax on "activates syntax highlighting among other things
set background=dark "set hg group to dark
set backspace=indent,eol,start "Fixes the backspace
set conceallevel=1 "Allows me to conceal latex syntax if not on line
set encoding=utf-8 "required by YCM
set expandtab
set foldlevel=99
set foldmethod=indent "fold your code.
set hidden "work with multiple unsaved buffers.
set incsearch "highlights as you search
set ignorecase
set smartcase
set rnu nu "sets line numbers
set splitbelow splitright
set termguicolors "True colors term support
set viminfo+=n~/.vim/viminfo
set omnifunc=syntaxcomplete#Complete
set undodir="~/.vim/undo/"
set undofile
set laststatus=2
set showcmd
set guifont=MesloLGMDZ\ Nerd\ Font\ Bold\ 16

"Key remapping
let mapleader = ","
noremap <leader>s :source ~/.vim/vimrc<cr>
noremap <leader>e <C-w><C-w>
noremap <leader>z [s1z=
noremap <leader>p "+p
noremap <leader>P "+P
noremap <leader>f :Files<cr>
noremap <leader>c :cd %:p:h<cr>:pwd<cr>
noremap <leader><cr> o<Esc>
noremap <space>h <C-w>h
noremap <space>j <C-w>j
noremap <space>k <C-w>k
noremap <space>l <C-w>l
noremap <down> :resize +2<Cr>
noremap <up> :resize -2<cr>
noremap <right> :vertical resize +2<CR>
noremap <left> :vertical resize -2<CR>
inoremap jk <Esc>
vnoremap <leader>y "*y :let @+=@*<cr>
nmap <leader>1 :bn<cr>
nmap <leader>2 :bp<cr>
nmap <leader>3 :retab<cr>
nmap <leader>5 :call SpellToggle()<cr>

"Extra
let g:gruvbox_italic='1'
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection='0'
let g:gruvbox_termcolors='256'
let g:AutoPairsFlyMode=0
source ~/.config/nvim/fzfConfig.vim
source ~/.config/nvim/myhighlights.vim
colorscheme gruvbox "colorscheme

if executable('rg')
        set grepprg=rg\ --vimgrep
        set grepformat^=%f:%l:%c:%m
endif


" statusline
set noshowmode
let g:currentmode={
       \ 'n'  : 'NORMAL ',
       \ 'v'  : 'VISUAL ',
       \ 'V'  : 'V·Line ',
       \ '' : 'V·Block ',
       \ 'i'  : 'INSERT ',
       \ 'R'  : 'Replace ',
       \ 'r'  : 'Replace ',
       \ 'Rv' : 'V·Replace ',
       \ 'c'  : 'Command ',
       \ 't'  : 'Terminal ',
       \ 's'  : 'Select ',
       \ '!'  : 'Shell '
       \}

set statusline=%{toupper(g:currentmode[mode()])}%{toupper(&spelllang)}\ %{b:gitbranch}%<%F%h%m%r%=%-5.(%l,%c%V%)\ %y

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END


function! SpellToggle()
    if &spell
      setlocal spell! spelllang&
    else
      setlocal spell spelllang=en_us
    endif
endfunction
