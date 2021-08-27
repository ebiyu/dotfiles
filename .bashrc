export PATH=$HOME/.ebcli-virtual-env/executables:$HOME/.anyenv/bin:$HOME/.nodebrew/current/bin:$HOME.local/bin:$PATH

export LANG=ja_JP.UTF-8
export LANG_ALL=ja_JP.UTF-8
export LANG_MESSAGES=ja_JP.UTF-8
export HISTSIZE=100000
export HISTCONTROL=ignoreboth
export LESSCHARSET=utf-8

export PIPENV_VENV_IN_PROJECT=true

shopt -s autocd

bash_conf=~/.bash_conf
. $bash_conf/alias.bash
. $bash_conf/func.bash
. $bash_conf/prompt.bash
 
type column > /dev/null 2>&1 && alias csv="column -s, -t"
type xdg-open > /dev/null 2>&1 && alias open=xdg-open
type "xsel" > /dev/null 2>&1 && alias pbcopy='xsel --clipboard --input'

# eval `ssh-agent`
# ssh-add .ssh/id_rsa

#export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

# supress warning in new mac
export BASH_SILENCE_DEPRECATION_WARNING=1

# brew
type "/opt/homebrew/bin/brew" > /dev/null 2>&1 && eval "$(/opt/homebrew/bin/brew shellenv)"


## anyenv
type anyenv > /dev/null 2>&1 && eval "$(anyenv init -)"


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
# eval "$(pyenv init --path)"
