" specification: https://github.com/tritask/tritask-sta/blob/master/specification.md

nnoremap T <cmd>split ~/tritra/task.trita<CR>
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
    augroup TritaskFile
        au!
        filetype plugin indent on
        au BufWritePre <buffer> call s:tritra_on_save()
        au BufWrite <buffer> call execute("!~/tritra/sync.sh&", "silent")
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

    " TODO: skip

    " Sort mark
    if date_parsed == 0
        " inbo
        let sortmark = " "
    elseif date_parsed < today_unixtime
        " ye
        let sortmark = "4"
    elseif date_parsed > today_unixtime
        " tom
        let sortmark = "3"
    elseif endtime_parsed == 0
        " tt, ts
        let sortmark = "2"
    else
        " td
        let sortmark = "1"
    endif

    " day of week
    if date_parsed != 0
        let dow = strftime("%a", date_parsed)
    else
        let dow = "   "
    endif

    let newLine = join([sortmark, date, dow, starttime, endtime, description], " ")

    call setline(".", newLine)
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
command! TritraEndTask call TritraEndTask()

function! TritraWalkADay()
    language time C
    let line = getline(".")
    if line[1] != " " || line[12] != " "
        return
    endif

    let date        = line[2:11]
    let date_parsed = strptime("%Y/%m/%d", date)
    let remain      = line[13:]

    if date_parsed == 0
        return
    endif

    let date = strftime("%Y/%m/%d", date_parsed + 24 * 60 * 60)

    let newLine = join(["3", date, remain], " ")
    call setline(".", newLine)
    call s:tritra_validate_line()
endfunction
command! TritraWalkADay call TritraWalkADay()

function! TritraChangeToToday()
    language time C
    let line = getline(".")
    if line[12] != " " ||
        \ line[16] != " " || line[22] != " " || line[28] != " "
        return
    endif

    let date = strftime("%Y/%m/%d %a", localtime())
    let description = trim(line[29:])

    " rep
    let rep_match_list = matchlist(description, "\\vrep:(\\d+)")
    if len(rep_match_list) != 0
        let N = rep_match_list[1]
        let nextdate = strftime("%Y/%m/%d %a", localtime() + N * 24 * 60 * 60)
    endif

    let updatedLine = join(["3", date, repeat(" ", 11), description], " ")
    call setline(".", updatedLine)
endfunction
command! TritraChangeToToday call TritraEndTask()

