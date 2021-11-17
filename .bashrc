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

function parse_aws_profile {
    profile="${AWS_PROFILE}"
    if [[ -z "${profile}" ]]; then
        _prompt_awsprof=""
    else
        _prompt_awsprof="/ AWS:%F{magenta}${profile}%f"
    fi
    echo "${_prompt_awsprof}"
}

#export PS1="\[\e[31m\]\`nonzero_return\`\[\e[m\]\[\e[35m\]`_prompt_hostname`\[\e[m\]\[\e[32m\]\w\[\e[m\] \[\e[34m\]\`parse_git_branch\`\[\e[m\]\[\e[31m\]\[\e[m\]`parse_aws_profile`\\$ "
#export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0

# supress warning in new mac
export BASH_SILENCE_DEPRECATION_WARNING=1

# brew
type "/opt/homebrew/bin/brew" > /dev/null 2>&1 && eval "$(/opt/homebrew/bin/brew shellenv)"


## anyenv
type anyenv > /dev/null 2>&1 && eval "$(anyenv init -)"

if type pyenv > /dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
fi

ls ~/.git-completion.bash > /dev/null 2>&1 && source ~/.git-completion.bash
#source ~/.git-completion.bash

if type "xsel" > /dev/null 2>&1; then
    alias pbcopy='xsel --clipboard --input'
fi

if type "yarn" > /dev/null 2>&1; then
    export PATH="$PATH:`yarn global bin`"
fi

if type "$HOME/bin/eagle-9.6.2/eagle" > /dev/null 2>&1; then
    alias eagle="$HOME/bin/eagle-9.6.2/eagle > /dev/null 2>&1 &"
fi
