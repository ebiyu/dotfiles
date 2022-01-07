export PATH=$HOME/.ebcli-virtual-env/executables:$HOME/.anyenv/bin:$HOME/.nodebrew/current/bin:$HOME.local/bin:$PATH

export LANG=ja_JP.UTF-8
export LANG_ALL=ja_JP.UTF-8
export LANG_MESSAGES=ja_JP.UTF-8

# python
export PIPENV_VENV_IN_PROJECT=true

type anyenv > /dev/null 2>&1 && eval "$(anyenv init -)"

if type pyenv > /dev/null 2>&1; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
fi

# cotowali
export PATH="$HOME/.konryu/bin:$PATH"
type konryu > /dev/null 2>&1 && eval "$(konryu init)"

export PATH=$HOME/dotfiles/bin:$PATH
