nnoremap m <cmd>tabnew ~/ChangeLog<cr>
augroup MyMemo
    au!
    au BufRead,BufNewFile ChangeLog* set filetype=changelog
augroup END
