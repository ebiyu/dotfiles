" vim:set foldmethod=marker commentstring="%s:
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set backspace=indent,eol,start
set showcmd "入力中のコマンドを表示
set hidden "buffer切り替え時に保存を促さない
set history=1000 "コマンド履歴
set background=dark
colorscheme hybrid

set shell=/bin/zsh

" dein.vimによるプラグイン管理"{{{
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('Shougo/neomru.vim')
call dein#add('shougo/unite.vim')
call dein#add('shougo/neoyank.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('airblade/vim-gitgutter')
call dein#add('t9md/vim-textmanip')

call dein#end()

"Uniteの設定"{{{
nnoremap <silent> sr :<C-u>Unite file_mru<CR>
nnoremap <silent> sb :<C-u>Unite buffer<CR>
nnoremap <silent> sf :<C-u>Unite buffer file_mru<CR>
"}}}
"NERDTreeの設定"{{{
nnoremap <silent> <C-e> :<C-u>NERDTree<CR>
let NERDTreeShowHidden = 1 "隠しファイルを既定で表示

autocmd vimenter * NERDTree "起動時にNERDTreeを表示

"}}}
"neoyankの設定"{{{
nnoremap <silent> sy :<C-u>Unite history/yank<CR>
"}}}
"gitgutterの設定"{{{
let g:gitgutter_highlight_lines = 1 "行のハイライト表示を有効化
"}}}
"textmanipの設定"{{{
vmap <C-j> <Plug>(textmanip-move-down)
vmap <C-k> <Plug>(textmanip-move-up)
vmap <C-h> <Plug>(textmanip-move-left)
vmap <C-l> <Plug>(textmanip-move-right)
vmap <C-d> <Plug>(textmanip-duplicate-down)
"}}}

"}}}

set hlsearch
nnoremap <Esc><Esc> :noh<Return>

set number
set cursorline

set showmatch
set matchtime=1

nnoremap Y y$

"メモ関連の機能"{{{
command Todo edit ~/Dropbox/Note/todo.txt
noremap Mw :write ~/Dropbox/Note/
noremap Ml :Unite file_rec:~/Dropbox/Note/ -buffer-name=note_list<CR>
noremap Mn :new<CR>
noremap Mt :Todo<CR>
"}}}

command Run !%
inoremap <silent> jj <ESC>

inoremap <silent> っj <ESC>
noremap い i

"矢印キーの無効化"{{{
noremap <Down> <Nop>
noremap <Up> <Nop>
noremap <Right> <Nop>
noremap <Left> <Nop>
inoremap <Down> <Nop>
inoremap <Up> <Nop>
inoremap <Right> <Nop>
inoremap <Left> <Nop>
"}}}

noremap ZQ <nop>

noremap + <C-a>gv
noremap - <C-x>gv
noremap g+ g<C-a>
noremap g- g<C-x>

noremap <Space>m  %
noremap <Space>h  ^
noremap <Space>l  $
noremap <Space>/  *

noremap j gj
noremap k gk

noremap! <C-c> <Esc>

" split"{{{
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
"}}}

" tab"{{{
noremap st :tabnew<Return>
noremap sn gt
noremap sp gT
noremap sw <C-w>c
"}}}

set clipboard=unnamed

syntax on
