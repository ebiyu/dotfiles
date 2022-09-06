if [ "$(uname)" = "Darwin" ]; then
    alias ls="ls -G"
    alias la="ls -Ga"
    alias ll="ls -Gl"
    alias lla="ls -Gla"
else
    if [ "$(uname)" = "Linux" ]; then
        alias ls="ls --color=auto"
        alias la="ls --color=auto -a"
        alias ll="ls --color=auto -l"
        alias lla="ls --color=auto -la"
    else
        alias la="ls -a"
        alias ll="ls -l"
        alias lla="ls -la"
    fi
fi
alias sl=ls
alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias l="less"
alias d=docker
alias dc="docker-compose"
alias dcp="docker-compose -f docker-compose.prod.yml"
#alias dotfiles="~/dotfiles/dot"
alias g=git
alias v=vim
alias vi=vim
alias t=tmux
alias clean-xcode="rm -rf ~/Library/Developer/Xcode/DerivedData"

alias todo="vim ~/task.trita"

type column > /dev/null 2>&1 && alias csv="column -s, -t"
type xdg-open > /dev/null 2>&1 && alias open=xdg-open
type "xsel" > /dev/null 2>&1 && alias pbcopy='xsel --clipboard --input'
type "$HOME/bin/eagle-9.6.2/eagle" > /dev/null 2>&1 && alias eagle="$HOME/bin/eagle-9.6.2/eagle > /dev/null 2>&1 &"

alias proj='cd ~/projects'

google() {
    local url="https://www.google.co.jp/search?q=${*// /+}"
    open "${url}"
}

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
