export LANG=ja_JP.UTF-8
alias ls="ls -G"
alias rm="rm -i"
alias la="ls -Ga"
alias ll="ls -Gl"
alias lla="ls -Gla"
alias g=git
alias l="less"
alias d=docker
alias dc="docker-compose"
alias dcp="docker-compose -f docker-compose.prod.yml"
type dot > /dev/null 2>&1 || alias dot="~/dotfiles/dot"

proj(){
    if [ -e "$HOME/projects" ]; then
        cd "$HOME/projects"
    else
        if [ -e "$HOME/Document/projects" ]; then
            cd "$HOME/Document/projects/"
        else
            echo "no project directory"
        fi
    fi
}
