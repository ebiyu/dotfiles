"インデント関係"{{{
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
"}}}

" white spaces
	set listchars=eol:↵,tab:»\ ,space:･
set list

set mouse=a

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
nnoremap <silent> <Esc><Esc> :noh<Return>
set ignorecase " 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set smartcase " 検索文字列に大文字が含まれている場合は区別して検索する
set statusline=%F%m%r%h%w\ [%{&ff}][%{&fenc}][%Y]\ %l/%L(%p%%)%=%{strftime(\"%Y/%m/%d\ (%a)\ %H:%M\")}
"}}}
