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

#zmv
autoload -U zmv
alias mmv='noglob zmv -W'

bindkey '^J' self-insert #C-jで改行

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
}

setopt prompt_subst #プロンプトで変数を展開

#プロンプトを設定
PROMPT='%F{blue}[%D %*]%f%F{green}[${battery_info}%%]%f %~${vcs_info_msg_0_}
%(?,$,%F{red}$%f) '
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

cdpath=(.. ~ ~/projects /Volumes ~/Desktop)

#空行でlsを実行#{{{
function gitls {
    echo 'git status'${(r:COLUMNS-10::-:)}
    git status -s
    echo 'ls'${(r:COLUMNS-2::-:)}
    ls
}
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
