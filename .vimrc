set number
set cursorline
set virtualedit=onemore
set laststatus=2
set scrolloff=4
set belloff=all

set confirm
set hidden
set autoread

set hlsearch
set incsearch
set ignorecase
set wrapscan

set list
set listchars=tab:»\ 
set expandtab
set tabstop=2
set shiftwidth=0
set softtabstop=-1
set autoindent
set smartindent

syntax on
set showmatch
set encoding=utf-8

noremap <S-h>   ^
noremap <S-l>   $

xnoremap <S-h>   ^
xnoremap <S-l>   $

inoremap <C-h> <BS>
inoremap <C-d> <Delete>
inoremap <C-j> <CR>
inoremap <C-k> <C-o>d$
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-f> <Right>
inoremap <C-b> <Left>

