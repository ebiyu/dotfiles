nnoremap <space>s <c-u>:source $MYVIMRC

" dein
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' . fnamemodify(s:dein_repo_dir, ':p')
if &runtimepath =~# 'dein.vim'
    call dein#begin(s:dein_dir)
        " load toml
        call dein#load_toml('~/.vim/dein.toml', {'lazy': 0})
        call dein#load_toml('~/.vim/dein_lazy.toml', {'lazy': 1})
        call dein#load_toml('~/.vim/ddu.toml', {'lazy': 1})
    call dein#end()

    filetype plugin indent on
    syntax enable

    call dein#save_state()

    " auto install dein plugin
    if dein#check_install()
        call dein#install()
    endif
endif

autocmd FileType ddu-ff call s:ddu_my_settings()
function! s:ddu_my_settings() abort
  nnoremap <buffer><silent> <CR>
        \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
  nnoremap <buffer><silent> <Space>
        \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
  nnoremap <buffer><silent> i
        \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
  nnoremap <buffer><silent> q
        \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
endfunction

autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
function! s:ddu_filter_my_settings() abort
  inoremap <buffer><silent> <CR>
  \ <Esc><Cmd>close<CR>
  nnoremap <buffer><silent> <CR>
  \ <Cmd>close<CR>
  nnoremap <buffer><silent> q
  \ <Cmd>close<CR>
endfunction

" old vim-plug settings
" if executable('node')
"     Plug 'neoclide/coc.nvim'
"     Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'vue', 'html', 'markdown'] }
"     Plug 'leafgarland/typescript-vim'
" endif

" Plug 'Shougo/unite.vim'
" Plug 'Shougo/neoyank.vim'
" Plug 'Shougo/neomru.vim'
" Plug 'tpope/vim-repeat'
" Plug 'posva/vim-vue'
" Plug 'chikamichi/mediawiki.vim'

" function s:is_plugged(name)
"     if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
"         return 1
"     else
"         return 0
"     endif
" endfunction

" if s:is_plugged("unite.vim")
"     nnoremap <silent> <space>f :<C-u>Unite buffer file_mru<CR>
"     nnoremap <silent> <space>y :<C-u>Unite history/yank<CR>
" endif


"インデント関係"{{{
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
"}}}

set formatoptions-=ro

augroup MyGroup
    autocmd!
    autocmd BufRead,BufNewFile *.go setlocal noexpandtab
    autocmd BufRead,BufNewFile *.yaml,*.yml,*.json,*.js,*.ts,*.jsx,*.tsx setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END

" white spaces
set listchars=tab:>\ ,trail:_
set list

set mouse=a

"オプションの設定"{{{
set backspace=indent,eol,start

set showcmd "入力中のコマンドを表示
set hidden "buffer切り替え時に保存を促さない
set history=1000 "コマンド履歴
set background=dark
set clipboard=unnamedplus,unnamed
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

set noswapfile

nnoremap Y y$
nnoremap x "_x

vnoremap <C-a> <C-a>gv
vnoremap <C-x> <C-x>gv
vnoremap g<C-a> g<C-a>gv
vnoremap g<C-x> g<C-x>gv
vnoremap > >gv
vnoremap < <gv

noremap j gj
noremap k gk

noremap gr gT
"noremap t gt
noremap <silent> T :tabnew<cr>
noremap <space>l gt
noremap <space>h gT
noremap <c-n> gt
noremap <c-k> gT

noremap <space> <nop>

noremap ; :

" emacs key binding in insert mode
cnoremap <c-n> <down>
cnoremap <c-p> <up>
inoremap <c-b> <left>
cnoremap <c-b> <left>
inoremap <c-f> <right>
cnoremap <c-f> <right>
inoremap <c-a> <home>
cnoremap <c-a> <home>
inoremap <c-e> <end>
cnoremap <c-e> <end>

" esc key
inoremap <silent> jj <ESC>
inoremap <silent> っj <ESC>

syntax on

" .vimlocalの読み込み
if filereadable(expand($HOME.'/local.vimrc'))
    source $HOME/local.vimrc
endif
