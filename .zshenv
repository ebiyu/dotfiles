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
alias t=tmux
alias trash='(){mv $1 ~/.Trash}'
alias bm='w3m -B'
alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'

alias gg='git log --graph --date=short --decorate=short --pretty=format:"%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s"'
alias gs='git status'
alias gcm='git commit'
alias gcma='git commit --amend'
alias gcn='git commit -m'
alias gca='git commit -a -m'
alias gco='git checkout'
alias gcop='git checkout -p'
alias ga='git add'
alias gaa='git add .'
alias gap='git add -p'
alias gd='git diff'
alias gds='git diff --staged'
alias gdh='git diff HEAD^ HEAD'
alias gl='git log'
alias glp='git log -p'
alias gps='git push origin $(git rev-parse --abbrev-ref HEAD)'
alias gpl='git pull origin $(git rev-parse --abbrev-ref HEAD)'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gb='git branch'
alias gm='git merge --no-ff'
alias gmff='git merge --ff'
alias grs='git reset'
alias grss='git reset --soft'
alias grsh='git reset --hard'
alias grsp='git reset -p'
alias grb='git rebase'
alias grbi='git rebase -i'
alias grbir='git rebase -i --root'
alias grbc='git rebase -continue'
#hubコマンド用
alias gbr='git browse'
alias gcl='git clone'
alias gpr='git pull-request'
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
    fi
}

function md2html(){
    pandoc $1 -o ${1%%.md}-md.html
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
        *.tex) textypeset $1
            if [ $? = 0 ]; then
                open ${1%%.tex}.pdf
            fi;;
        *.html) open $1;;
        *.cpp) g++ $1
            if [ $? = 0 ]; then
                echo 'compile complete!'
                ./a.out
            fi;;
        *.md) md2html $1
            if [ $? = 0 ]; then
                open ${1%%.md}-md.html
            fi;;
    esac
}
alias -s {py,rb,hs,php,sh,html,md}=run

function prev(){
    case $1 in
        *.tex) textypeset $1
            if [ $? = 0 ]; then
                open -g ${1%%.tex}.pdf
            fi;;
        *.html) open -g $1;;
        *.md) md2html $1
            if [ $? = 0 ]; then
                open -g ${1%%.md}-md.html
            fi;;
    esac
}

function op() {
    if [ -z "$1" ]; then
        open .
    else
        open "$@"
    fi
}
alias ql='qlmanage -p "$@" >& /dev/null'
