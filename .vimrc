" vim:set foldmethod=marker commentstring="%s:

"インデント関係"{{{
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
"空行でもインデントを維持する"{{{
nnoremap o oX<C-h>
nnoremap O OX<C-h>
inoremap <CR> <CR>X<C-h>
"}}}
"}}}

"オプションの設定"{{{
set backspace=indent,eol,start

set showcmd "入力中のコマンドを表示
set hidden "buffer切り替え時に保存を促さない
set history=1000 "コマンド履歴
set background=dark
set clipboard=unnamed
set showmatch "対応するかっこを挿入
set matchtime=1
set number "行番号を表示
set ruler
set cursorline "カーソル業を強調
set scrolloff=8
set autoread

set hlsearch
set incsearch
nnoremap <Esc><Esc> :noh<Return>
set ignorecase " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase " 検索文字列に大文字が含まれている場合は区別して検索する
set gdefault

set shell=/bin/zsh
"}}}

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
call dein#add('kana/vim-submode')
call dein#add('flazz/vim-colorschemes')
call dein#add('ujihisa/unite-colorscheme')
call dein#add('tpope/vim-fugitive')
call dein#add('szw/vim-tags')

call dein#end()

"Uniteの設定"{{{
nnoremap <silent> sr :<C-u>Unite register<CR>
nnoremap <silent> sb :<C-u>Unite buffer<CR>
nnoremap <silent> sf :<C-u>NERDTreeClose<CR>:<C-u>Unite buffer file_mru<CR>
let g:unite_source_file_mru_limit = 50
"}}}
"NERDTreeの設定"{{{
nnoremap <silent> <C-e> :<C-u>NERDTree<CR>
let NERDTreeShowHidden = 1 "隠しファイルを既定で表示

"ファイルを指定せず開いた時のみ起動時にNERDTreeを起動
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"他のバッファをすべて閉じた時にNERDTreeが開いていたらNERDTreeも一緒に閉じる。
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"}}}
"neoyankの設定"{{{
nnoremap <silent> sy :<C-u>Unite history/yank<CR>
"}}}
"gitgutterの設定"{{{
"}}}
"textmanipの設定"{{{
vmap <C-j> <Plug>(textmanip-move-down)
vmap <C-k> <Plug>(textmanip-move-up)
vmap <C-h> <Plug>(textmanip-move-left)
vmap <C-l> <Plug>(textmanip-move-right)
vmap <C-d> <Plug>(textmanip-duplicate-down)
"}}}
"submodeの設定"{{{
call submode#enter_with('winsize','n','','s>','<C-w>>')
call submode#enter_with('winsize','n','','s<','<C-w><')
call submode#enter_with('winsize','n','','s+','<C-w>+')
call submode#enter_with('winsize','n','','s-','<C-w>-')
call submode#map('winsize','n','','>','<C-w>>')
call submode#map('winsize','n','','<','<C-w><')
call submode#map('winsize','n','','+','<C-w>+')
call submode#map('winsize','n','','-','<C-w>-')
"}}}

"}}}

"jqコマンドの実行"{{{
command! -nargs=? Jq call s:Jq(<f-args>)
function! s:Jq(...)
    if 0 == a:0
        let l:arg = "."
    else
        let l:arg = a:1
    endif
    execute "%! jq \"" . l:arg . "\""
endfunction
"}}}

"hardcopyでpreview.appを開く
set printexpr=system('open\ -a\ Preview\ '.v:fname_in)\ .\ v:shell_error

"メモ関連の機能"{{{
command Todo edit ~/Dropbox/Note/todo.txt
command -nargs=1 MemoWrite :write ~/Dropbox/Note/<args>.txt
noremap Mw :MemoWrite 
command -nargs=0 MemoList :Unite file_rec:~/Dropbox/Note/ -buffer-name=note_list
noremap Ml :MemoList<CR>
noremap Mn :new<CR>
noremap Mt :Todo<CR>
"}}}

command Run !%

"キーマッピング"{{{

nnoremap Y y$
nnoremap x "_x

nnoremap <C-]> g<C-]> "タグが複数ある時に一覧表示

"日本語入力時でのキーマップ"{{{
inoremap <silent> っj <ESC>
noremap い i
"}}}

"数字の加算・減算"{{{
noremap + <C-a>
noremap - <C-x>
vmap + <C-a>gv
vmap - <C-x>gv
noremap g+ g<C-a>
noremap g- g<C-x>
"}}}

" localleaderの設定"{{{
let maplocalleader=" "
noremap <localleader>m  %
noremap <localleader>h  ^
noremap <localleader>l  $
noremap <localleader>/  *
nnoremap <localleader>s :up<cr>
nnoremap <localleader>w :close<cr>
nnoremap <localleader>q :quit<cr>
"}}}

noremap j gj
noremap k gk

inoremap <cr> <C-g>u<cr>

"Esc"{{{
inoremap <silent> jj <ESC>
inoremap <silent> jk <ESC>
noremap <C-c> <Esc>
noremap! <C-c> <Esc>
"}}}

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
"}}}

colorscheme hybrid

syntax on
