# vim:set foldmethod=marker commentstring=#%s:

#gitの補完
fpath=(~/.zsh/completion $fpath)

#補完
autoload -U compinit
compinit -u

disable r

shell_common=~/dotfiles/shell_common
. $shell_common/alias.bash

alias :q=exit

alias -g G='| grep'
alias -g L='| less'
alias -g ...="../.."
alias -g ....="../../.."

#zmv
autoload -U zmv
alias mmv='noglob zmv -W'

bindkey '^J' self-insert #C-jで改行

zstyle ':completion:*' verbose yes
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

#プロンプトの設定#{{{

#git情報の表示#{{{
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示
#}}}

#プロンプト更新時
precmd () {
    vcs_info #git
    which pmset &> /dev/null
    if [ $? = 0 ]; then
        export battery_info=$(pmset -g ps | awk 'match($0,/[0-9]{1,3}%/){print substr($0, RSTART, RLENGTH - 1)}') #バッテリー残量
    else
        export battery_info=""
    fi
    if [ -n "$SSH_CONNECTION" ]; then
        echo -e "${(r:COLUMNS::-:)}"
    else
        echo -e "\033[0;31m${(r:COLUMNS::-:)}\033[0;39m"
    fi

    if ! [ -z "$SSH_CONNECTION" ]; then
        host_info="$USER@$HOST "
    else
        host_info=""
    fi
}

setopt prompt_subst #プロンプトで変数を展開

#プロンプトを設定
PROMPT='%B${host_info}%b%F{cyan}[%D %*]%f%F{yellow}[${battery_info}%%]%f %F{green}%~%f${vcs_info_msg_0_}
%(?,,%F{red}[$?] %f)$ '
PROMPT2='${vimmode}>'

#C-zでfgを実行#{{{
function run-fglast {
    zle push-input
    BUFFER="fg %"
    zle accept-line
}

zle -N run-fglast
bindkey "^z" run-fglast
#}}}

#}}}

#コマンド履歴#{{{
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data
setopt hist_ignore_space

#履歴の検索#{{{
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "" history-beginning-search-backward-end
bindkey "" history-beginning-search-forward-end
#}}}
#}}}

setopt ignoreeof #C-dでのログアウトを無効化
setopt auto_pushd #移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_cd
setopt list_packed # 補完候補を詰めて表示する
setopt nolistbeep # 補完候補表示時などにピッピとビープ音をならないように設定
zstyle ':completion:*' list-colors di=34 ln=35 ex=31 #補完に色をつける

cdpath=(.. ~ ~/projects /Volumes ~/Desktop ~/Dropbox)

#空行でlsを実行#{{{
function my_enter {
    if [[ -n "$BUFFER" ]]; then
        builtin zle .accept-line
        return 0
    fi
    BUFFER=" gitls"
    builtin zle .accept-line
}
zle -N my_enter
bindkey '^m' my_enter
#}}}

# anyenv
# https://naoblo.net/archives/1046
if type anyenv > /dev/null 2>&1; then
    if [ ! -f ~/.anyenv-rc.zsh  ]; then
        echo "setting anyenv-rc.zsh"
        anyenv init - zsh > ~/.anyenv-rc.zsh
        chmod 755 ~/.anyenv-rc.zsh
    fi
    source ~/.anyenv-rc.zsh
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

export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

