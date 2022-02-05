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
noremap T gt
noremap <space>l gt
noremap <space>h gT

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
    nnoremap <silent> <space><space> :call CocAction('doHover')<CR>
    nmap <silent> <C-]> <Plug>(coc-definition)
    nmap <silent> <C-t> <Plug>(coc-references)
endif

if s:is_plugged("unite.vim")
    nnoremap <silent> <space>f :<C-u>Unite buffer file_mru<CR>
    nnoremap <silent> <space>y :<C-u>Unite history/yank<CR>
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
