syntax on
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set backspace=indent,eol,start
set showcmd

set number
set cursorline
set showmatch

set list listchars=tab:\▸\-

noremap <Down> <Nop>
noremap <Up> <Nop>
noremap <Right> <Nop>
noremap <Left> <Nop>
noremap ZQ <nop>

noremap <Space>m  %
noremap <Space>h  ^
noremap <Space>l  $
noremap <Space>/  *

noremap! <C-j> <Esc>

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
noremap sw :q<Return>
