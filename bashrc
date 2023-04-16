export HISTSIZE=100000
export HISTCONTROL=ignoreboth
export LESSCHARSET=utf-8

shopt -s autocd

# disable screen lock with ^S / ^Q
if [[ -t 0 ]]; then
    stty stop undef
    stty start undef
fi

# disable exit with ^D less than 5 times
export IGNOREEOF=4


bash_conf=~/dotfiles/bash
. $bash_conf/prompt.bash

shell_common=~/dotfiles/shell_common
. $shell_common/alias.bash
. $shell_common/env.bash

# supress warning in new mac
export BASH_SILENCE_DEPRECATION_WARNING=1

# brew
type "/opt/homebrew/bin/brew" > /dev/null 2>&1 && eval "$(/opt/homebrew/bin/brew shellenv)"

# anyenv
# https://naoblo.net/archives/1046
if type anyenv > /dev/null 2>&1; then
    if [ ! -f ~/.anyenv-rc.bash  ]; then
        echo "setting anyenv-rc.bash"
        anyenv init - bash > ~/.anyenv-rc.bash
        chmod 755 ~/.anyenv-rc.bash
    fi
    source ~/.anyenv-rc.bash
fi

if type pyenv > /dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    if [ ! -f ~/.pyenv-rc.bash  ]; then
        echo "setting pyenv-rc.bash"
        pyenv init --path > ~/.pyenv-rc.bash
        chmod 755 ~/.pyenv-rc.bash
    fi
    source ~/.pyenv-rc.bash
fi

# yarn
# type "yarn" > /dev/null 2>&1 && export PATH="$PATH:`yarn global bin`"

# git completion
ls ~/.git-completion.bash > /dev/null 2>&1 && source ~/.git-completion.bash

# 履歴を記録するcdの再定義（pushdの利用）
function cd {
    if [ -z "$1" ] ; then
        #cd-
        # cd 連打で余計な $DIRSTACK を増やさない
        test "$PWD" != "$HOME" && pushd $HOME > /dev/null
    else
        pushd "$1" > /dev/null
    fi  
}
alias dirs="dirs -v"
function cd-() {
    ! which peco >/dev/null 2>&1 && dirs -v && return 0
    local pushd_number=$(dirs -v | peco | perl -anE 'say $F[0]')
    [[ -z $pushd_number ]] && return 1
    pushd +$pushd_number > /dev/null
    return $?
}
alias pd="pushd"


function ghql() {
  local selected_file=$(ghq list --full-path | peco --query "$LBUFFER")
  if [ -n "$selected_file" ]; then
    if [ -t 1 ]; then
      echo ${selected_file}
      cd ${selected_file}
      pwd
    fi
  fi
}

bind -x '"\201": ghql'
bind '"\C-]":"\201\C-m"'
