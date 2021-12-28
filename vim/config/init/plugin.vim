try
    call plug#begin()
    Plug 'tpope/vim-surround'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-fugitive'
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'vim-scripts/grep.vim'
    call plug#end()


    function s:is_plugged(name)
        if exists('g:plugs') && has_key(g:plugs, a:name) && isdirectory(g:plugs[a:name].dir)
            return 1
        else
            return 0
        endif
    endfunction

    if s:is_plugged("grep.vim")
        let Grep_Skip_Dirs = '.svn .git node_modules' 
        let Grep_Default_Options = '-I'   "ignore binary files
        let Grep_Skip_Files = '*.bak *~' 
        autocmd QuickFixCmdPost *grep* cwindow
    endif

catch /E117.*/
    echo "vim-plug not installed"
endtry
