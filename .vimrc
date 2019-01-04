" vim:set foldmethod=marker commentstring="%s:

"インデント関係"{{{
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
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
set scrolloff=8
set autoread
set timeoutlen=500
set laststatus=2 "常にステータス行を表示

set modelines=5
set hlsearch
set incsearch
nnoremap <Esc><Esc> :noh<Return>
set ignorecase " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase " 検索文字列に大文字が含まれている場合は区別して検索する
set statusline=%F%m%r%h%w\ [%{&ff}][%{&fenc}][%Y]\ %l/%L(%p%%)%=%{strftime(\"%Y/%m/%d\ (%a)\ %H:%M\")}
"}}}

"キーマッピング"{{{
nnoremap Y y$
nnoremap x "_x

noremap + <C-a>
noremap - <C-x>
vnoremap + <C-a>gv
vnoremap - <C-x>gv
noremap g+ g<C-a>
noremap g- g<C-x>

vnoremap > >gv
vnoremap < <gv

nnoremap sa ggVG

noremap <space> <nop>
noremap <space>h  ^
noremap <space>l  $
nnoremap <space>c :lcd %:h<cr>
nnoremap <space>r :lcd %:h<cr>:<c-u>w<cr>:<c-u>!run %<cr>
nnoremap <space>p :lcd %:h<cr>:<c-u>w<cr>:<c-u>!prev %<cr>

noremap <silent> <space><space> :set cursorline<cr>:sleep 100m<cr>:set nocursorline<cr>

noremap j gj
noremap k gk

noremap s <nop>
"ウィンドウ
noremap ss :split<Return>
noremap sv :vsplit<Return>
noremap sS :Se<Return>
noremap sV :Ve<Return>
noremap sh <C-w>h
noremap sj <C-w>j
noremap sk <C-w>k
noremap sl <C-w>l
noremap sH <C-w>H
noremap sJ <C-w>J
noremap sK <C-w>K
noremap sL <C-w>L
"タブ
noremap st :tabnew<Return>
noremap sn gt
noremap sp gT
noremap <silent> sN :tabm +1<cr>
noremap <silent> sP :tabm -1<cr>
noremap sw <C-w>c

"コマンドライン
cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <c-b> <left>
cnoremap <c-f> <right>
cnoremap <c-a> <home>
cnoremap <c-e> <end>
"}}}

"一時ファイルの機能"{{{
command! Tcd :cd ~/tmpfiles
nnoremap sm :e ~/tmpfiles/<C-r>=strftime('%Y%m%d%H%M%S')<CR>.
"}}}

".vimlocalの読み込み"{{{
if filereadable(expand($HOME.'/local.vimrc'))
    source $HOME/local.vimrc
endif
" }}}

let g:activate_plugin=0
" dein.tomlによるプラグイン管理"{{{
if g:activate_plugin==1
    set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

    if dein#load_state(expand('~/.vim/dein'))
        call dein#begin(expand('~/.vim/dein'))
        call dein#load_toml(expand('~/.vim/dein.toml'))
        call dein#end()
        call dein#save_state()
    endif
endif
"}}}

if filereadable(expand($HOME.'/.vim/colors/hybrid.vim'))
    colorscheme hybrid
endif
syntax on
