export LANG=ja_JP.UTF-8
alias ls="ls -G"
alias rm="rm -i"
alias la="ls -Ga"
alias ll="ls -Gl"
alias lla="ls -Gla"
alias l="less"
alias d=docker
alias dc="docker-compose"
alias dcp="docker-compose -f docker-compose.prod.yml"
type dot > /dev/null 2>&1 || alias dot="~/dotfiles/dot"

if type hub > /dev/null 2>&1; then
    alias g=hub
else
    alias g=git
fi

proj(){
    if [ -e "$HOME/projects" ]; then
        cd "$HOME/projects"
    else
        if [ -e "$HOME/Documents/projects" ]; then
            cd "$HOME/Documents/projects/"
        else
            echo "no project directory"
        fi
    fi
}
