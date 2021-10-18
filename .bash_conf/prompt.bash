function _prompt_hostname() {
    if ! [ -z "$SSH_CONNECTION" ]; then
        echo "$USER@$HOSTNAME "
    fi
}
function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo "[$RETVAL] "
}

# get current branch in git repo
function parse_git_branch() {
	BRANCH="$(git symbolic-ref --short HEAD 2> /dev/null)"
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo "(${BRANCH}${STAT}) "
	else
		echo ""
	fi
}

# get current status of git repo
function parse_git_dirty {
	local status=$(git status --short --ignore-submodules 2> /dev/null) || return 0
	
	local unstaged   # add 前のファイル (行頭にスペース1つ開けて M or D)
	local staged     # add 済のファイル (行頭に A or M or D)
	local untracked  # 新規作成ファイル (行頭に ??)
	
	# Unstaged
	if [ -n "$(echo "$status" | cut -c 2 | tr -dc 'ACDMRU')" ]; then
		unstaged='*'
	fi
	
	# Staged
	if [ -n "$(echo "$status" | cut -c 1 | tr -dc 'ACDMRU')" ]; then
		staged='+'
	fi
	
	# Untracked
	if [ -n "$(echo "$status" | tr -dc '?')" ]; then
		untracked='?'
	fi

	# ステータス文字列を結合する
	local files_status="$unstaged$staged$untracked"
	
	# いずれかの記号があれば先頭にスペースを入れておく
	if [ -n "$files_status" ]; then
		files_status=" $files_status"
	fi
}

export PS1="\[\e[31m\]\`nonzero_return\`\[\e[m\]\[\e[35m\]`_prompt_hostname`\[\e[m\]\[\e[32m\]\w\[\e[m\] \[\e[34m\]\`parse_git_branch\`\[\e[m\]\[\e[31m\]\[\e[m\]\\$ "
