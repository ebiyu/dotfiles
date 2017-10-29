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
set scrolloff=8
set autoread
set timeoutlen=500
set laststatus=2 "常にステータス行を表示

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
call dein#add('airblade/vim-gitgutter')
call dein#add('t9md/vim-textmanip')
call dein#add('kana/vim-submode')
call dein#add('flazz/vim-colorschemes')
call dein#add('ujihisa/unite-colorscheme')
call dein#add('tpope/vim-fugitive')
call dein#add('szw/vim-tags')
call dein#add('Shougo/vimfiler.vim')
call dein#add('Lokaltog/vim-easymotion')
call dein#add('cohama/lexima.vim')
call dein#add('Shougo/neocomplcache')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')

call dein#end()

"Uniteの設定"{{{
nnoremap <silent> sr :<C-u>Unite register<CR>
nnoremap <silent> sb :<C-u>Unite buffer<CR>
nnoremap <silent> sf :<C-u>Unite buffer file_mru<CR>
let g:unite_source_file_mru_limit = 50
"}}}
"vimfilerの設定"{{{
nnoremap <silent> <C-e> :VimFilerExplore -toggle -winwidth=30 -find -force-hide<Cr>
let g:vimfiler_enable_auto_cd = 1
"キーマップの変更
autocmd FileType vimfiler nmap <buffer> F <Plug>(vimfiler_toggle_maximize_window)
"ファイルを指定せず開いた時のみ起動時にvimfilerを起動
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && !has("gui_running") | VimFiler -force-quit | endif

"}}}
"neoyankの設定"{{{
nnoremap <silent> sy :<C-u>Unite history/yank<CR>
"}}}
"textmanipの設定"{{{
vnoremap <C-j> <Plug>(textmanip-move-down)
vnoremap <C-k> <Plug>(textmanip-move-up)
vnoremap <C-h> <Plug>(textmanip-move-left)
vnoremap <C-l> <Plug>(textmanip-move-right)
vnoremap <C-d> <Plug>(textmanip-duplicate-down)
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
"easymotionの設定"{{{
map f <Plug>(easymotion-fl)
map t <Plug>(easymotion-tl)
map F <Plug>(easymotion-Fl)
map T <Plug>(easymotion-Tl)
map <space>f <Plug>(easymotion-s)
map <space>j <Plug>(easymotion-jumptoanywhere)
"}}}
"maximaの設定"{{{
call lexima#add_rule({'char': '<TAB>', 'at': '\%#)', 'leave': 1})
call lexima#add_rule({'char': '<TAB>', 'at': '\%#"', 'leave': 1})
call lexima#add_rule({'char': '<TAB>', 'at': '\%#''', 'leave': 1})
call lexima#add_rule({'char': '<TAB>', 'at': '\%#]', 'leave': 1})
call lexima#add_rule({'char': '<TAB>', 'at': '\%#}', 'leave': 1})

call lexima#add_rule({'char': '$', 'input_after': '$', 'filetype': 'tex'})
call lexima#add_rule({'char': '$', 'at': '\%#\$', 'leave': 1, 'filetype': 'tex'})
call lexima#add_rule({'char': '<BS>', 'at': '\$\%#\$', 'delete': 1, 'filetype': 'tex'})
call lexima#add_rule({'char': '<TAB>', 'at': '\%#\$', 'leave': 1, 'filetype': 'tex'})
"}}}
"neosnippetの設定"{{{
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)
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
command! -nargs=1 MemoWrite :write ~/Dropbox/Note/<args>.txt
noremap Mw :MemoWrite 
command! -nargs=0 MemoList :Unite file_rec:~/Dropbox/Note/ -buffer-name=note_list
noremap Ml :MemoList<CR>
noremap Mn :new<CR>
noremap MM :tabnew + ~/Dropbox/Note/todo.txt<CR>o<CR><C-R>=strftime("%Y/%m/%d (%a) %H:%M")<CR><CR>
"}}}

" 一定時間入力がなかったらノーマルモードに {{{
set updatetime=20000
function s:InsertToNormal()
    call feedkeys("\<Esc>")
endfunction
autocmd CursorHoldI * call s:InsertToNormal()
"}}}

"キーマッピング"{{{

nnoremap Y y$
nnoremap x "_x

"タグが複数ある時に一覧表示
nnoremap <C-]> g<C-]>

"数字の加算・減算"{{{
noremap + <C-a>
noremap - <C-x>
vnoremap + <C-a>gv
vnoremap - <C-x>gv
noremap g+ g<C-a>
noremap g- g<C-x>
"}}}

vnoremap > >gv
vnoremap < <gv

" spaceの設定"{{{
noremap <space> <nop>
noremap <space>m  %
noremap <space>h  ^
noremap <space>l  $
noremap <space>/  *
nnoremap <space>s :up<cr>
nnoremap <space>w :close<cr>
nnoremap <space>q :quit<cr>
nnoremap <space>P "0P
nnoremap <space>P "0p
nnoremap <space>c :lcd %:h<cr>
nnoremap <space>r :lcd %:h<cr>:<c-u>!%<cr>

noremap <silent> <space><space> :set cursorline<cr>:sleep 100m<cr>:set nocursorline<cr>
"}}}

"コマンドラインでのマッピング"{{{
cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <c-b> <left>
cnoremap <c-f> <right>
cnoremap <c-a> <home>
cnoremap <c-e> <end>
"}}}

noremap j gj
noremap k gk

inoremap <cr> <C-g>u<cr>

nnoremap <F6> <ESC>i<C-R>=strftime("%Y/%m/%d (%a) %H:%M")<CR><CR>
inoremap <F6> <C-R>=strftime("%Y/%m/%d (%a) %H:%M")

"Esc"{{{
inoremap <silent> jj <ESC>
inoremap <silent> jk <ESC>
inoremap <silent> kj <ESC>
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
noremap st <C-w>t
noremap sb <C-w>b
"}}}

" tab"{{{
noremap st :tabnew<Return>
noremap sn gt
noremap sp gT
noremap sw <C-w>c
"}}}

"カッコから出やすいようにC-fに右を割り当て
inoremap <C-f> <right>

"}}}

augroup csv
autocmd!
autocmd BufRead,BufNewFile *.csv setfiletype csv
autocmd FileType csv nnoremap <buffer> <Tab> f,l
autocmd FileType csv nnoremap <buffer> <S-Tab> 2F,l
autocmd FileType csv inoremap <buffer> <Tab> <C-o>f,<C-o>l
autocmd FileType csv inoremap <buffer> <S-Tab> <C-o>2F,<C-o>l
augroup end

inoremap <C-g> <C-g>u

colorscheme hybrid

syntax on
