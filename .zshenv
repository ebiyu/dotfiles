# 日本語を使用
export LANG=ja_JP.UTF-8

#add PATH
export PATH="$PATH:~/bin"  

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

alias -g ...='../..'
alias -g ....='../../..'

alias -g G='|egrep'
alias -g S='|sort'
alias -g L='|less'
alias -g LS='|less -s'
alias -g DN=/dev/null


#Trash
alias trash='(){mv $1 ~/.Trash}'

#alias -s
alias -s {png,jpg,bmp,PNG,JPG,BMP}=open

function op() {
    if [ -z "$1" ]; then
        open .
    else
        open "$@"
    fi
}
alias ql='qlmanage -p "$@" >& /dev/null'
