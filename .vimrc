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

let g:activate_plugin=0

runtime! config/init/*.vim

if filereadable(expand($HOME.'/.vim/colors/hybrid.vim'))
    colorscheme hybrid
endif
syntax on
