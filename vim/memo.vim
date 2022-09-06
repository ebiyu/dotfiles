nnoremap m <cmd>tabnew ~/Dropbox/ChangeLog<cr>
augroup MyMemo
    au!
    au BufRead,BufNewFile ChangeLog* set filetype=changelog
augroup END
