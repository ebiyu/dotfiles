# 日本語を使用
export LANG=ja_JP.UTF-8

#add PATH
export PATH="$PATH:~/bin"  

#git completion
fpath=(~/.zsh/completion $fpath)

#completion
autoload -U compinit
compinit -u

#zmv
autoload -U zmv
alias mmv='noglob zmv -W'

#git prompt
autoload -Uz vcs_info

zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示

precmd () { vcs_info }

#プロンプトの設定
setopt prompt_subst

PROMPT='
%(?,,%K{red}COMMAND FAILED%k
)%F{blue}[%D %*]%f%~${vcs_info_msg_0_}
%F{red}$%f '

#alias
alias cls=clear
alias ls='ls -G'
alias rm='rm -i'
alias la='ls -Ga'
alias gist='git status'
alias google='(){open "http://www.google.co.jp/search?q=$1"}'
alias ql='qlmanage -p'
alias dict='(){open dict:///$1}'

alias zshrc='vim ~/.zshrc'

#Trash
alias trash='(){mv $1 ~/.Trash}'

#alias -s
alias -s {png,jpg,bmp,PNG,JPG,BMP}=open

#history
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

#history search
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# ディレクトリ名を入力するだけで移動
setopt auto_cd

# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd

# コマンド訂正
setopt correct

#auto_cd
setopt auto_cd

# 補完候補を詰めて表示する
setopt list_packed

# 補完候補表示時などにピッピとビープ音をならないように設定
setopt nolistbeep

#補完に色をつける
zstyle ':completion:*' list-colors di=34 ln=35 ex=31

#空行でlsを実行
function my_enter {
    if [[ -n "$BUFFER" ]]; then
        builtin zle .accept-line
        return 0
    fi
    BUFFER="ls"
    builtin zle .accept-line
}
zle -N my_enter
bindkey '^m' my_enter
