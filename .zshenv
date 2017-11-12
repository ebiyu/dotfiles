# vim:set foldmethod=marker commentstring=#%s:
# 日本語を使用
export LANG=ja_JP.UTF-8

#add PATH
export PATH="$PATH:$HOME/bin:$HOME/Qt/5.9/clang_64/bin"  

#alias#{{{
alias ls='ls -G'
alias rm='rm -i'
alias la='ls -Ga'
alias ll='ls -Gl'
alias lla='ls -Gla'
alias google='(){w3m "http://www.google.co.jp/search?q=$1"}'
alias ql='qlmanage -p'
alias dict='(){open dict:///$1}'
alias g=hub
alias v=vim
alias trash='(){mv $1 ~/.Trash}'
alias bm='w3m -B'
alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
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
alias .zshrc='source .zshrc'
alias .zshenv='source .zshenv'
function textypeset(){
    platex $1
    if [ $? = 0 ]; then
        dvipdfmx ${1%%.tex}.dvi
        open ${1%%.tex}.pdf
    fi
}

function run()
{
    case $1 in
        *.py) python3 $1;;
        .zshrc|.zshenv|.zsh_profile) source $1;;
        *.rb) ruby $1;;
        *.hs) runhaskell $1;;
        *.php) php -f $1;;
        *.sh) sh $1;;
        *.tex) textypeset $1;;
        *.html) open $1;;
    esac
}
alias -s {py,rb,hs,php,sh,html}

function op() {
    if [ -z "$1" ]; then
        open .
    else
        open "$@"
    fi
}
alias ql='qlmanage -p "$@" >& /dev/null'
