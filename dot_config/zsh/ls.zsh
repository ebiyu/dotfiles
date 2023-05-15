# config around cd / ls

function gitls {
    git status > /dev/null 2>&1
    if [[ $? == 0 ]]; then
        echo 'git status'${(r:COLUMNS-10::-:)}
        git status -s
    fi
    echo 'ls'${(r:COLUMNS-2::-:)}
    ls
}

function cd {
    builtin cd "$@" && gitls
}

# run ls on blank line
function my_enter {
    if [[ -n "$BUFFER" ]]; then
        builtin zle .accept-line
        return 0
    fi
    BUFFER=" gitls"
    builtin zle .accept-line
}
zle -N my_enter
bindkey '^m' my_enter

