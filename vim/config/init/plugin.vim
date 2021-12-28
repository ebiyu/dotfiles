try
    call plug#begin()
    Plug 'tpope/vim-surround'
    call plug#end()
catch /E117.*/
    echo "vim-plug not installed"
endtry
