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

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent

syntax on
set showmatch
set encoding=utf-8

noremap j gj
noremap k gk
noremap <S-h>   ^
noremap <S-j>   }
noremap <S-k>   {
noremap <S-l>   $

vnoremap <S-h>   ^
vnoremap <S-j>   }
vnoremap <S-k>   {
vnoremap <S-l>   $

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

