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
set ruler
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
set visualbell

set shell=/bin/zsh
"}}}

function! WordCount()
    if &filetype=='tex'
        return ''
    else
        let s:old_status = v:statusmsg
        let position = getpos(".")
        exe ":silent normal g\<c-g>"
        let s:stat = v:statusmsg
        "let s:word_count = 0
        "if stat != '--No lines in buffer--'
        "  let s:word_count = str2nr(split(v:statusmsg)[11])
          let v:statusmsg = s:old_status
        "end
        call setpos('.', position)
        return s:stat
    endif
endfunction

set statusline=%F%m%r%h%w\ [%{&ff}][%{&fenc}][%Y]\ %l/%L(%p%%)\ %{WordCount()}%=%{strftime(\"%Y/%m/%d\ (%a)\ %H:%M\")}

" dein.tomlによるプラグイン管理"{{{
if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

if dein#load_state(expand('~/.vim/dein'))
    call dein#begin(expand('~/.vim/dein'))
    call dein#load_toml(expand('~/.vim/dein.toml'))
    call dein#end()
    call dein#save_state()
endif
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

nnoremap sa ggVG

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
nnoremap <space>r :lcd %:h<cr>:<c-u>w<cr>:<c-u>!run %<cr>
nnoremap <space>p :lcd %:h<cr>:<c-u>w<cr>:<c-u>!prev %<cr>

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

nnoremap <F6> <ESC>i<C-R>=strftime("%Y/%m/%d (%a) %H:%M")<CR><CR>
inoremap <F6> <C-R>=strftime("%Y/%m/%d (%a) %H:%M")

"Esc"{{{
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

"comment out"{{{
augroup comment
autocmd!
autocmd Bufread *.cpp,*.c noremap <buffer> s/ :s+^+//+<cr>:noh<cr>
autocmd Bufread *.cpp,*c noremap <buffer> s? :s+//++<cr>:noh<cr>
autocmd Bufread *.py noremap <buffer> s/ :s+^+#+<cr>:noh<cr>
autocmd Bufread *.py noremap <buffer> s? :s+#++<cr>:noh<cr>
autocmd Bufread *.vimrc noremap <buffer> s/ :s+^+"+<cr>:noh<cr>
autocmd Bufread *.vimrc noremap <buffer> s? :s+"++<cr>:noh<cr>
augroup end
"}}}

inoremap <c-a> <c-o>^
inoremap <c-e> <c-o>$

"}}}

"一時ファイルの機能"{{{
command! Tcd :cd ~/tmpfiles
nnoremap sm :e ~/tmpfiles/<C-r>=strftime('%Y%m%d%H%M%S')<CR>.
"}}}

"テンプレート読み込み
nnoremap sn :0r ~/template/template.%:e<cr>G

" 英語の縮約形{{{
ab dont don't
ab doesnt doesn't
ab cant can't
ab couldnt couldn't
ab wouldnt wouldn't
ab inst isn't
ab Im I'm
ab Ive I've
ab youre you're
ab were we're
ab theyre they're
ab Id I'd
ab shes she's
ab hes he's
ab itss it's

ab govt government
"}}}

"CSV"{{{
augroup csv
autocmd!
autocmd BufRead,BufNewFile *.csv setfiletype csv
autocmd FileType csv nnoremap <buffer> <Tab> f,l
autocmd FileType csv nnoremap <buffer> <S-Tab> 2F,l
autocmd FileType csv inoremap <buffer> <Tab> <C-o>f,<C-o>l
autocmd FileType csv inoremap <buffer> <S-Tab> <C-o>2F,<C-o>l
augroup end
"}}}

"texのためのショートカット"{{{
augroup tex
autocmd!
autocmd BufRead,BufNewFile *.tex setfiletype tex
autocmd Bufread,BufNewFile *.tex inoremap <buffer> (( \left(
autocmd Bufread,BufNewFile *.tex inoremap )) \right)
autocmd Bufread,BufNewFile *.tex inoremap <C-d> \partial 
autocmd Bufread,BufNewFile *.tex inoremap <C-e> \varepsilon
augroup END
"}}}

"format{{{
let g:clang_format_enable = 1
function! s:clang_format()
    if g:clang_format_enable == 1
        let now_line = line(".")-1
        exec ":%! clang-format"
        exec "." . now_line
    endif
endfunction
if executable("clang-format")
    augroup cpp_clang_format
        autocmd!
        autocmd Bufwrite,FileWritePre,FileAppendPre *.[ch]pp,*dot call s:clang_format()
        autocmd BufRead,BufNewFile *.[ch]pp nnoremap <buffer> sb :let g:clang_format_enable=0<cr>
        autocmd BufRead,BufNewFile *.[ch]pp nnoremap <buffer> sB :let g:clang_format_enable=1<cr>
    augroup END
endif
let g:yapf_enable = 0
function! s:yapf()
    if g:yapf_enable == 1
        let now_line = line(".")-1
        exec ":%!yapf"
        exec "." . now_line
    endif
endfunction
if executable("yapf")
    augroup format
        autocmd!
        autocmd Bufwrite,FileWritePre,FileAppendPre *.py call s:yapf()
        autocmd BufRead,BufNewFile *.py nnoremap <buffer> sb :let g:yapf_enable=0<cr>
        autocmd BufRead,BufNewFile *.py nnoremap <buffer> sB :let g:yapf_enable=1<cr>
    augroup END
endif
"}}}

"{{{ brainfuck
augroup bfc
autocmd!
autocmd BufRead,BufNewFile *.bfc inoremap <buffer> s <
autocmd BufRead,BufNewFile *.bfc inoremap <buffer> d >
autocmd BufRead,BufNewFile *.bfc inoremap <buffer> f +
autocmd BufRead,BufNewFile *.bfc inoremap <buffer> g -
autocmd BufRead,BufNewFile *.bfc inoremap <buffer> h .
autocmd BufRead,BufNewFile *.bfc inoremap <buffer> j ,
autocmd BufRead,BufNewFile *.bfc inoremap <buffer> k [
autocmd BufRead,BufNewFile *.bfc inoremap <buffer> l ]
autocmd BufRead,BufNewFile *.bfc set filetype=bfc
augroup END
"}}}
"iTerm2のカーソルを変える"{{{
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
"}}}

inoremap <C-g> <C-g>u

colorscheme hybrid
set t_Co=256

syntax on
