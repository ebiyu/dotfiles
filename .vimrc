syntax on
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set backspace=indent,eol,start
set showcmd
set hidden "buffer切り替え時に保存を促さない
set background=dark
colorscheme hybrid

set shell=/bin/zsh

set hlsearch
nnoremap <Esc><Esc> :noh<Return>

set number
set cursorline

set showmatch
set matchtime=1

nnoremap Y y$

inoremap <silent> jj <ESC>

"矢印キーの無効化
noremap <Down> <Nop>
noremap <Up> <Nop>
noremap <Right> <Nop>
noremap <Left> <Nop>
noremap! <Down> <Nop>
noremap! <Up> <Nop>
noremap! <Right> <Nop>
noremap! <Left> <Nop>

noremap ZQ <nop>

noremap + <C-a>
noremap - <C-x>

noremap <Space>m  %
noremap <Space>h  ^
noremap <Space>l  $
noremap <Space>/  *

noremap j gj
noremap k gk

noremap! <C-c> <Esc>

" split
noremap s <nop>
noremap ss :split<Return>
noremap sv :vsplit<Return>
noremap sS :S<Return>
noremap sV :Ve<Return>
noremap sh <C-w>h
noremap sj <C-w>j
noremap sk <C-w>k
noremap sl <C-w>l
noremap sH <C-w>H
noremap sJ <C-w>J
noremap sK <C-w>K
noremap sL <C-w>L

" tab
noremap st :tabnew<Return>
noremap sn gt
noremap sp gT
noremap sw <C-w>c

set clipboard=unnamed
