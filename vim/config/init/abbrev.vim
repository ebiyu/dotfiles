augroup abb
    autocmd!
    " sql
    autocmd FileType sql iabbrev <buffer> select SELECT
    autocmd FileType sql iabbrev <buffer> from FROM
    autocmd FileType sql iabbrev <buffer> where WHERE
    autocmd FileType sql iabbrev <buffer> order ORDER
    autocmd FileType sql iabbrev <buffer> by BY

    " python
    autocmd FileType python iabbrev <buffer> improt import
augroup END
