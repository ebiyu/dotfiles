" specification: https://github.com/tritask/tritask-sta/blob/master/specification.md

nnoremap T <cmd>split ~/Dropbox/task.trita<CR>
augroup Tritask
    au!
    filetype plugin indent on
    au BufRead,BufNewFile *.trita set filetype=trita
    au FileType trita call s:trita_file()
augroup END

function! s:trita_file() abort
    nnoremap <buffer> q <cmd>w<cr><cmd>bd<cr>
    nnoremap <buffer> Q <cmd>!~/tritra/sync.sh<cr><cmd>e<cr>
    nnoremap <buffer> o <cmd>call TritraNewLine(v:true)<cr>
    nnoremap <buffer> O <cmd>call TritraNewLine(v:false)<cr>
    nnoremap <buffer> S <cmd>call TritraStartTask()<cr>
    nnoremap <buffer> E <cmd>call TritraEndTask()<cr>
    nnoremap <buffer> W <cmd>call TritraWalkADay()<cr>
    nnoremap <buffer> T <cmd>call TritraChangeToToday()<cr>
    nnoremap <buffer> I <cmd>call TritraChangeToInbox()<cr>
    nnoremap <buffer> F <cmd>call TritraChangeToFuture()<cr>
    augroup TritaskFile
        au!
        filetype plugin indent on
        au BufWritePre <buffer> call s:tritra_on_save()
        " au BufWrite <buffer> call execute("!~/tritra/sync.sh&", "silent")
    augroup END
endfunction

command Line call s:tritra_validate_line()

function! s:tritra_validate() abort
    %call s:tritra_validate_line()
endfunction

function! s:parse_time(str) abort
    return strptime("%Y/%m/%d %H:%M", "2020/02/02 " . a:str)
endfunction

function! s:tritra_validate_line() abort

    language time C
    let line = getline(".")
    if line[1] == " "
        let line = line[2:]
    endif
    if line[10] != " " ||
        \ line[14] != " " || line[20] != " " || line[26] != " "
        let line = repeat(" ", 27) . line
    endif

    let date        = line[0:9]
    let date_parsed = strptime("%Y/%m/%d", date)
    let dow         = line[11:13]
    let starttime   = line[15:19]
    let starttime_parsed = strptime("%Y/%m/%d %H:%M", "2020/02/02 " . starttime)
    let endtime     = line[21:25]
    let endtime_parsed = strptime("%Y/%m/%d %H:%M", "2020/02/02 " . endtime)
    let description = trim(line[27:])

    " format HHMM to HH:MM
    if date_parsed == 0
        let date_parsed = strptime("%Y%m%d", date)
    endif
    if date_parsed != 0
        let date = strftime("%Y/%m/%d", date_parsed)
    endif

    if starttime_parsed == 0
        let starttime_parsed = strptime("%Y/%m/%d %H%M", "2020/02/02 " . starttime)
    endif
    if starttime_parsed != 0
        let starttime = strftime("%H:%M", starttime_parsed)
    endif
    if endtime_parsed == 0
        let endtime_parsed = strptime("%Y/%m/%d %H%M", "2020/02/02 " . endtime)
    endif
    if endtime_parsed != 0
        let endtime = strftime("%H:%M", endtime_parsed)
    endif

    let today_unixtime = strptime("%Y/%m/%d", strftime("%Y/%m/%d", localtime()))

    " Error check
    if date_parsed == 0
        " Inbox
        let date = repeat(" ", 10)
        let starttime = repeat(" ", 5)
        let starttime_parsed = 0
        let endtime   = repeat(" ", 5)
        let endtime_parsed = 0
    elseif date_parsed < today_unixtime
        " Yesterday 
        if starttime_parsed == 0 || endtime_parsed == 0
            " YESTERDAY TODO
            " YESTERDAY START

            let date        = strftime("%Y/%m/%d", localtime())
            let date_parsed = strptime("%Y/%m/%d", date)
            let starttime   = repeat(" ", 5)
            let starttime_parsed = 0
            let endtime   = repeat(" ", 5)
            let endtime_parsed = 0
        endif
    elseif date_parsed > today_unixtime
        " Tomorrow
        if starttime_parsed != 0 || endtime_parsed != 0
            " TOMORROW START
            " TOMORROW DONE
            let date        = strftime("%Y/%m/%d", localtime())
            let date_parsed = strptime("%Y/%m/%d", date)
            let starttime   = repeat(" ", 5)
            let starttime_parsed = 0
            let endtime   = repeat(" ", 5)
            let endtime_parsed = 0
        endif
    else
        " Today
        if starttime_parsed == 0 && endtime_parsed != 0
            let date        = strftime("%Y/%m/%d", localtime())
            let date_parsed = strptime("%Y/%m/%d", date)
            let starttime   = repeat(" ", 5)
            let starttime_parsed = 0
            let endtime   = repeat(" ", 5)
            let endtime_parsed = 0
        endif
    endif

    " Hold
    let hold_match_list = matchlist(description, "\\vhold:(\\d+)")
    if len(hold_match_list) != 0
        let N = hold_match_list[1]
        let date        = strftime("%Y/%m/%d", localtime() + N * 24 * 60 * 60)
        let date_parsed = strptime("%Y/%m/%d", date)
    endif

    " Tag input (':' -> ')')
    let description = substitute(description, "\\v^([A-Za-z0-9]+): (.+)$", "[\\1] \\2", "")

    " TODO: skip

    " Sort mark
    if date_parsed == 0
        " inbo
        let tasktype = "inbo"
    elseif date_parsed < today_unixtime
        let tasktype = "ye"
    elseif date_parsed > today_unixtime
        let tasktype = "tom"
    elseif endtime_parsed == 0
        if starttime_parsed == 0
            let tasktype = "tt"
        else
            let tasktype = "ts"
        endif
    else
        " td
        let tasktype = "td"
        "let sortmark = "1"
    endif
    let sortmark = s:get_sortmark(tasktype)

    " day of week
    if date_parsed != 0
        let dow = strftime("%a", date_parsed)
    else
        let dow = "   "
    endif

    let newLine = join([sortmark, date, dow, starttime, endtime, description], " ")

    call setline(".", newLine)
endfunction

function! s:get_sortmark(tasktype) abort
    if a:tasktype == "ye"
        return "4"
    elseif a:tasktype == "tom"
        return "3"
    elseif a:tasktype == "tt"
        return "2"
    elseif a:tasktype == "ts"
        return "1"
    elseif a:tasktype == "td"
        return "3"
    else
        return " "
    endif
endfunction

function! s:tritra_on_save() abort
    let line = line(".")

    silent! g/^\s*$/d
    noh

    call s:tritra_validate()

    sort
    call cursor(line, 0)
endfunction

function! TritraNewLine(next)
    let line = getline(".")
    let header = line[0:28]
    let line = line(".")
    if a:next
        call append(line, header)
        call cursor(line + 1, 0)
    else
        call append(line - 1, header)
        call cursor(line, 0)
    endif
    startinsert!
endfunction

function! TritraStartTask()
    language time C
    let line = getline(".")
    if line[12] != " " ||
        \ line[16] != " " || line[22] != " " || line[28] != " "
        return
    endif

    let sortmark = "2"
    let date = strftime("%Y/%m/%d", localtime())
    let dow = strftime("%a", localtime())
    let starttime = strftime("%H:%M", localtime())
    let endtime   = repeat(" ", 5)
    let description = trim(line[29:])

    if description =~ "locked:1"
        echohl WarningMsg
            echomsg "This task is locked!"
        echohl None
        return
    endif

    let newLine = join([sortmark, date, dow, starttime, endtime, description], " ")

    call setline(".", newLine)
endfunction
command! TritraStartTask call TritraStartTask()

function! TritraEndTask() abort
    language time C
    let line = getline(".")
    if line[12] != " " ||
        \ line[16] != " " || line[22] != " " || line[28] != " "
        return
    endif

    let date = strftime("%Y/%m/%d", localtime())
    let dow = strftime("%a", localtime())
    let starttime   = line[17:21]
    let starttime_parsed = s:parse_time(starttime)
    let endtime = strftime("%H:%M", localtime())
    let description = trim(line[29:])

    if starttime_parsed == 0
        let starttime = endtime
    endif

    if description =~ "locked:1"
        echohl WarningMsg
            echomsg "This task is locked!"
        echohl None
        return
    endif

    let updatedLine = join(["2", date, dow, starttime, endtime, description], " ")
    call setline(".", updatedLine)

    " rep
    let rep_match_list = matchlist(description, "\\vrep:(\\d+)")
    if len(rep_match_list) != 0
        let N = rep_match_list[1]
        let nextdate = strftime("%Y/%m/%d %a", localtime() + N * 24 * 60 * 60)
        let newItemLine = join(["3", nextdate, repeat(" ", 11), description], " ")
        call append(".", newItemLine)
    endif
endfunction

function! TritraWalkADay()
    language time C
    let line = getline(".")
    if line[1] != " " || line[12] != " "
        return
    endif

    let date        = line[2:11]
    let date_parsed = strptime("%Y/%m/%d", date)
    let remain      = line[13:]

    if remain =~ "locked:1"
        echohl WarningMsg
            echomsg "This task is locked!"
        echohl None
        return
    endif

    if date_parsed == 0
        return
    endif

    let date = strftime("%Y/%m/%d", date_parsed + 24 * 60 * 60)

    let newLine = join(["3", date, remain], " ")
    call setline(".", newLine)
    call s:tritra_validate_line()
endfunction

function! TritraChangeToToday()
    language time C
    let line = getline(".")
    if line[12] != " " ||
        \ line[16] != " " || line[22] != " " || line[28] != " "
        return
    endif

    let date = strftime("%Y/%m/%d %a", localtime())
    let description = trim(line[29:])

    if description =~ "locked:1"
        echohl WarningMsg
            echomsg "This task is locked!"
        echohl None
        return
    endif

    " rep
    let rep_match_list = matchlist(description, "\\vrep:(\\d+)")
    if len(rep_match_list) != 0
        let N = rep_match_list[1]
        let nextdate = strftime("%Y/%m/%d %a", localtime() + N * 24 * 60 * 60)
    endif

    let updatedLine = join(["3", date, repeat(" ", 11), description], " ")
    call setline(".", updatedLine)
endfunction

function! TritraChangeToFuture()
    language time C
    let line = getline(".")
    if line[12] != " " ||
        \ line[16] != " " || line[22] != " " || line[28] != " "
        return
    endif

    let date = "3000/01/01 Wed"
    let description = trim(line[29:])

    if description =~ "locked:1"
        echohl WarningMsg
            echomsg "This task is locked!"
        echohl None
        return
    endif

    let updatedLine = join(["3", date, repeat(" ", 11), description], " ")
    call setline(".", updatedLine)
endfunction

function! TritraChangeToInbox() abort
    language time C
    let line = getline(".")
    if line[12] != " " ||
        \ line[16] != " " || line[22] != " " || line[28] != " "
        return
    endif

    let date = strftime("%Y/%m/%d %a", localtime())
    let description = trim(line[29:])

    if description =~ "locked:1"
        echohl WarningMsg
            echomsg "This task is locked!"
        echohl None
        return
    endif

    let updatedLine = repeat(" ", 29) . description
    call setline(".", updatedLine)
endfunction

