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

"noremap <silent> <space><space> :set cursorline<cr>:sleep 100m<cr>:set nocursorline<cr>

noremap j gj
noremap k gk

"コマンドライン
cnoremap <c-n> <down>
cnoremap <c-p> <up>
cnoremap <c-b> <left>
cnoremap <c-f> <right>
cnoremap <c-a> <home>
cnoremap <c-e> <end>

" esc key
inoremap <silent> jj <ESC>

