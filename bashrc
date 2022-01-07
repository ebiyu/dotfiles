export PATH=$HOME/.ebcli-virtual-env/executables:$HOME/.anyenv/bin:$HOME/.nodebrew/current/bin:$HOME.local/bin:$PATH

export LANG=ja_JP.UTF-8
export LANG_ALL=ja_JP.UTF-8
export LANG_MESSAGES=ja_JP.UTF-8
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


bash_conf=~/.bash_conf
. $bash_conf/alias.bash
. $bash_conf/func.bash
. $bash_conf/prompt.bash
 
# supress warning in new mac
export BASH_SILENCE_DEPRECATION_WARNING=1

# brew
type "/opt/homebrew/bin/brew" > /dev/null 2>&1 && eval "$(/opt/homebrew/bin/brew shellenv)"

# python
export PIPENV_VENV_IN_PROJECT=true

# anyenv
# https://naoblo.net/archives/1046
# anyenv init - --no-rehash > ~/.anyenv-rc.sh
if [ -f ~/.anyenv-rc.sh ]; then
    source ~/.anyenv-rc.sh
else
    type anyenv > /dev/null 2>&1 && eval "$(anyenv init -)"
fi

if type pyenv > /dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
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

# cotowali
export PATH="$HOME/.konryu/bin:$PATH"
type konryu > /dev/null 2>&1 && eval "$(konryu init)"




export PATH=$HOME/dotfiles/bin:$PATH
