" vim:set foldmethod=marker commentstring="%s:

"一時ファイルの機能"{{{
command! Tcd :cd ~/tmpfiles
nnoremap sm :e ~/tmpfiles/<C-r>=strftime('%Y%m%d%H%M%S')<CR>.
"}}}

".vimlocalの読み込み"{{{
if filereadable(expand($HOME.'/local.vimrc'))
    source $HOME/local.vimrc
endif
" }}}

runtime! config/init/*.vim

syntax on
