export PATH=$HOME/.ebcli-virtual-env/executables:$HOME/.anyenv/bin:$HOME/.nodebrew/current/bin:$HOME.local/bin:$PATH

export LANG=ja_JP.UTF-8
export LANG_ALL=ja_JP.UTF-8
export LANG_MESSAGES=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8

# python
export PIPENV_VENV_IN_PROJECT=true

# cotowali
export PATH="$HOME/.konryu/bin:$PATH"
type konryu > /dev/null 2>&1 && eval "$(konryu init)"

export PATH=$HOME/dotfiles_private/bin:$HOME/dotfiles/bin:$PATH
