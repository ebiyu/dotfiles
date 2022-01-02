" vim:set foldmethod=marker commentstring="%s:


if filereadable(expand($HOME.'/local.vimrc'))
    source $HOME/local.vimrc
endif
" }}}

runtime! config/init/*.vim

syntax on
