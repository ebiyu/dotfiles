echo "Hey"

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
alias g=git
alias t=tmux

type column > /dev/null 2>&1 && alias csv="column -s, -t"

# open command
type xdg-open > /dev/null 2>&1 && alias open=xdg-open
type explorer.exe > /dev/null 2>&1 && alias open="explorer.exe ."
type wslview > /dev/null 2>&1 && alias open="wslview ."

type "xsel" > /dev/null 2>&1 && alias pbcopy='xsel --clipboard --input'

alias -g G='| grep'
alias -g L='| less'
alias -g ...="../.."
alias -g ....="../../.."

alias px="pipenv run"
alias dj="pipenv run python manage.py"

type vim > /dev/null 2>&1 && alias vi=vim
type nvim > /dev/null 2>&1 && alias vi=nvim



alias clean-xcode="rm -rf ~/Library/Developer/Xcode/DerivedData"
