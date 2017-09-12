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

#プロンプトの設定

#git
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true #formats 設定項目で %c,%u が使用可
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" #commit されていないファイルがある
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" #add されていないファイルがある
zstyle ':vcs_info:*' formats "%F{cyan}%c%u(%b)%f" #通常
zstyle ':vcs_info:*' actionformats '[%b|%a]' #rebase 途中,merge コンフリクト等 formats 外の表示

precmd () {
    vcs_info #git
    export battery_info=$(pmset -g ps | awk 'match($0,/[0-9]{1,3}%/){print substr($0, RSTART, RLENGTH - 1)}') #バッテリー残量
}

setopt prompt_subst

#vim mode
bindkey -v
#zshプロンプトにモード表示####################################
function zle-line-init zle-keymap-select {
  case $KEYMAP in
    vicmd)
    export vimmode=[%F{yellow}NOR%f]
    ;;
    main|viins)
    export vimmode=[INS]
    ;;
  esac
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

PROMPT='
%F{blue}[%D %*]%f${vimmode}%F{green}[${battery_info}%%]%f %~${vcs_info_msg_0_}
%(?,$,%F{red}$%f) '

#alias
alias cls=clear
alias ls='ls -G'
alias rm='rm -i'
alias la='ls -Ga'
alias gist='git status'
alias google='(){open "http://www.google.co.jp/search?q=$1"}'
alias ql='qlmanage -p'
alias dict='(){open dict:///$1}'
alias g=git

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
bindkey "" history-beginning-search-backward-end
bindkey "" history-beginning-search-forward-end

# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd

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
