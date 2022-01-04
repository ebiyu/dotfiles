try
    call plug#begin()
    Plug 'tpope/vim-surround'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'

    if executable('fzf')
        Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
        Plug 'junegunn/fzf.vim'
    else
        Plug 'ctrlpvim/ctrlp.vim'
        echo  "fzf not installed"
    endif

    Plug 'vim-scripts/grep.vim'
    Plug 'lambdalisue/fern.vim'
    Plug 'lambdalisue/fern-git-status.vim'
    Plug 'neoclide/coc.nvim'
    Plug 'Shougo/unite.vim'
    Plug 'Shougo/neoyank.vim'
    Plug 'Shougo/neomru.vim'
    Plug 'leafgarland/typescript-vim'
    Plug 'prettier/vim-prettier', { 'do': 'yarn install', 'for': ['javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'css', 'less', 'scss', 'json', 'graphql', 'vue', 'html'] }
    Plug 'editorconfig/editorconfig-vim'
    Plug 'cohama/lexima.vim'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-commentary'
    call plug#end()


catch /E117.*/
    echo "vim-plug not installed"
endtry

function s:is_plugged(name)
    if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
        return 1
    else
        return 0
    endif
endfunction

if s:is_plugged("vim-gitgutter")
    highlight SignColumn ctermbg=black
    highlight GitGutterAdd ctermfg=blue
    highlight GitGutterChange ctermfg=green
    highlight GitGutterDelete ctermfg=red
    highlight GitGutterChangeDelete ctermfg=magenta
    highlight GitGutterAddLine ctermbg=64 "green
    highlight GitGutterChangeLine ctermbg=24 "blue
    highlight GitGutterDeleteLine ctermbg=1 "red
    highlight GitGutterChangeDeleteLine ctermbg=55 "purple
endif

if s:is_plugged("grep.vim")
    let Grep_Skip_Dirs = '.svn .git node_modules' 
    let Grep_Default_Options = '-I'   "ignore binary files
    let Grep_Skip_Files = '*.bak *~' 
    autocmd QuickFixCmdPost *grep* cwindow
endif

if s:is_plugged("fern.vim")
    let g:fern#default_hidden=1
endif

if s:is_plugged("vim-prettier")
    "let g:prettier#autoformat_config_present = 1
    let g:prettier#autoformat = 1
    let g:prettier#autoformat_require_pragma = 0
endif


if s:is_plugged("vim-prettier")
    let g:coc_global_extensions = [
        \ 'coc-tsserver',
        \ 'coc-jedi',
        \ 'coc-eslint',
        \ 'coc-html',
        \ 'coc-css',
        \ 'coc-yaml',
        \ 'coc-highlight',
        \ 'coc-json',
        \ ]
endif
