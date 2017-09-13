# vim:set foldmethod=marker commentstring=#%s:
# 日本語を使用
export LANG=ja_JP.UTF-8

#add PATH
export PATH="$PATH:$HOME/bin"  

#alias#{{{
alias ls='ls -G'
alias rm='rm -i'
alias la='ls -Ga'
alias gist='git status'
alias google='(){open "http://www.google.co.jp/search?q=$1"}'
alias ql='qlmanage -p'
alias dict='(){open dict:///$1}'
alias g=git
alias trash='(){mv $1 ~/.Trash}'
#}}}

#global alias#{{{
alias -g ...='../..'
alias -g ....='../../..'

alias -g G='|egrep'
alias -g S='|sort'
alias -g L='|less'
alias -g LS='|less -s'
alias -g DN=/dev/null
#}}}

#alias -s#{{{
function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar Jxvf $1;;
    *.zip) unzip $1;;
    *.lzh) lha e $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.Z) tar zxvf $1;;
    *.gz) gzip -d $1;;
    *.Z) uncompress $1;;
    *.tar) tar xvf $1;;
  esac
}
alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract
alias -s {png,jpg,bmp,PNG,JPG,BMP}=open
alias -s {zshrc,zshrc,zsh_profile}=source
alias -s py=pyton
alias -s txt=cat
alias -s html=open
alias -s rb=ruby
alias -s hs=runhaskell
alias -s php='php -f'
#}}}

function op() {
    if [ -z "$1" ]; then
        open .
    else
        open "$@"
    fi
}
alias ql='qlmanage -p "$@" >& /dev/null'
