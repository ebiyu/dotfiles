".vimlocalの読み込み
if filereadable(expand($HOME.'/local.vimrc'))
    source $HOME/local.vimrc
endif

runtime! config/init/plugin.vim
runtime! config/init/options.vim
runtime! config/init/keymap.vim

syntax on

