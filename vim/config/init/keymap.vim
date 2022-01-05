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

noremap <space> <nop>
noremap <space>h  ^
noremap <space>l  $

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
inoremap <silent> っj <ESC>

" config
command! Config e ~/.vim/config/init/

function s:is_plugged(name)
    if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
        return 1
    else
        return 0
    endif
endfunction


if s:is_plugged("coc.nvim")
    nnoremap <space><space> :call CocAction('doHover')<CR>
    nmap <silent> <C-]> <Plug>(coc-definition)
    nmap <silent> <C-t> <Plug>(coc-references)
endif

if s:is_plugged("unite.vim")
    nmap <space> [unite]
    nnoremap <silent> [unite]f :<C-u>Unite buffer file_mru<CR>
    nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
endif

if s:is_plugged("fern.vim")
    " nnoremap <C-S-b> :Fern . -reveal=% -drawer -toggle -width=40<CR>
    nnoremap <C-b> :Fern . -reveal=%<CR>
endif


if s:is_plugged("fzf.vim")
    fun! FzfOmniFiles()
        let is_git = system('git status')
        if v:shell_error
            :Files
        else
            :GFiles
        endif
    endfun
    nnoremap <silent> <C-p> :call FzfOmniFiles()<CR>
endif
