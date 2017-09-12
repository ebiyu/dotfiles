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

alias zshrc='vim ~/.zshrc'

#Trash
alias trash='(){mv $1 ~/.Trash}'

#alias -s
alias -s {png,jpg,bmp,PNG,JPG,BMP}=open

