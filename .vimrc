<<<<<<< HEAD
" vim:set foldmethod=marker commentstring="%s:


=======
".vimlocalの読み込み
>>>>>>> fec8251793a0186468e19de25263c028d0cc67ab
if filereadable(expand($HOME.'/local.vimrc'))
    source $HOME/local.vimrc
endif

runtime! config/init/plugin.vim
runtime! config/init/options.vim
runtime! config/init/keymap.vim

syntax on

