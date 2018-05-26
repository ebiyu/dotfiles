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
alias q='qlmanage -p'
alias dict='(){open dict:///$1}'
if [ $USER = 6585151351 ]; then
    alias g=git
else
    alias g=hub
fi
alias v=vim
alias t=tmux
alias ta='tmux a'
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

#{{{extrect
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
#}}}

alias -s {png,jpg,bmp,PNG,JPG,BMP}=open
alias zshrc='source ~/.zshrc'
alias zshenv='source ~/.zshenv'

#{{{textypeset
function textypeset(){
    platex $1
    if [ $? = 0 ]; then
        dvipdfmx ${1%%.tex}.dvi
    fi
}
#}}}
#{{{md2html
function md2html(){
    pandoc $1 -o ${1%%.md}-md.html
}
#}}}

#{{{run
function run()
{
    case $1 in
        *.py) python3 $1;;
        .zshrc|.zshenv|.zsh_profile) source $1;;
        *.rb) ruby $1;;
        *.hs) runhaskell $1;;
        *.php) php -f $1;;
        *.sh) sh $1;;
        *.tex) platex $1;;
        *.html) open $1;;
        *.cpp) g++-7 $1
            if [ $? = 0 ]; then
                echo 'compile complete!'
                ./a.out
            fi;;
        *.md) md2html $1
            if [ $? = 0 ]; then
                open ${1%%.md}-md.html
            fi;;
        *.bfc) python3 bfc.py $1
    esac
}
alias -s {py,rb,hs,php,sh,html,md}=run
#}}}
#{{{prev
function prev(){
    case $1 in
        *.tex) textypeset $1
            if [ $? = 0 ]; then
                open ${1%%.tex}.pdf
            fi;;
        *.html) open -g $1;;
        *.md) md2html $1
            if [ $? = 0 ]; then
                open -g ${1%%.md}-md.html
            fi;;
    esac
}
#}}}

#git関係
alias c="git commit -a -m 'hoge'"
function s(){
    if git push origin $(git rev-parse --abbrev-ref HEAD) ; then
        git commit -a -m 'hoge'
        git push origin $(git rev-parse --abbrev-ref HEAD)
    fi
}

function op() {
    if [ -z "$1" ]; then
        open .
    else
        open "$@"
    fi
}
#}}}
alias ql='qlmanage -p "$@" >& /dev/null'
