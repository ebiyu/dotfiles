nnoremap m <cmd>tabnew ~/ChangeLog<cr>

let g:changelog_username = "Yusuke Ebihara <yusuke@ebihara.me>"
augroup MyMemo
    au!
    au BufRead,BufNewFile ChangeLog* set filetype=changelog
    au FileType changelog call s:changelog_file()
augroup END

function! s:changelog_file() abort
    nnoremap <buffer> <leader>o <cmd>call ChangelogAddEntry()<cr>
endfunction

function! ChangelogAddEntry() abort
    let formattedDate = strftime("%Y-%m-%d", localtime())
    let headingLine = formattedDate . "  " . g:changelog_username

    let found = search(headingLine)
    if found == 0
        call append(0, headingLine)
        call append(1, "")
        call append(2, "\t* ")
        call append(3, "")
        call cursor(3, 0)
        startinsert!
        return
    endif
    call cursor(found + 1, 0)
    let found = search("\\v\\d\\d\\d\\d-\\d\\d-\\d\\d", "", line("$"))
    if found == 0
        let found = line("$")
    endif

    " call append(found - 1, "")
    call append(found - 1, "\t* ")
    call append(found, "")
    call cursor(found, 0)
    startinsert!
endfunction
