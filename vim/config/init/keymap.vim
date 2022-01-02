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

" esc key
inoremap <silent> jj <ESC>

