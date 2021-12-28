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
    call plug#end()

    function s:is_plugged(name)
        if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
            return 1
        else
            return 0
        endif
    endfunction

    if s:is_plugged("fzf.vim")
        fun! FzfOmniFiles()
            let is_git = system('git status')
            if v:shell_error
                :Files
            else
                :GFiles
            endif
        endfun
        nnoremap <C-p> :call FzfOmniFiles()<CR>
    endif


    if s:is_plugged("grep.vim")
        let Grep_Skip_Dirs = '.svn .git node_modules' 
        let Grep_Default_Options = '-I'   "ignore binary files
        let Grep_Skip_Files = '*.bak *~' 
        autocmd QuickFixCmdPost *grep* cwindow
    endif

    if s:is_plugged("fern.vim")
        nnoremap <C-b> :Fern . -reveal=% -drawer -toggle -width=40<CR>
        let g:fern#default_hidden=1
    endif

catch /E117.*/
    echo "vim-plug not installed"
endtry
