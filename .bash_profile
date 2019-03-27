export PS1="\W \u\$ "

alias o=open
alias s='open -a Sublime\ Text'
alias glb='git -c color.ui=always branch --list | tr -d " *" | awk '\''{printf("%d %s\n", NR, $0)}'\'' 1>&2'
alias gbn='git checkout -b'
alias gs='git status'
alias gbname='git symbolic-ref --short -q HEAD'
alias gbdmerged='git branch --merged master | grep -v "^[ *]*master$" | xargs git branch -d'
alias gp='git push -u'
alias gd='git diff'
alias gl='git log'
alias gc='git commit'
alias osf='open SnapshotTestImages/FailureDiffs'
alias rsf='rm -rf SnapshotTestImages/FailureDiffs'
alias gud='TGBN="$OLD_GBNAME"; gco d && git pull; gco -; OLD_GBNAME="$TGBN"'

alias tpswd='security find-internet-password -ws "secure.tesco.com" | pbcopy'
alias xr='osascript -e "tell application \"Xcode\" to activate" -e "tell application \"Xcode\" to run active workspace document"'
gpr() {
	open "$(git config --get remote.origin.url | sed s_:_/_ | sed s_git@_http://_ | sed 's_\.git__')/compare/$(gbname)?expand=1&body=JIRA:%20https%3A%2F%2Fjira.global.tesco.org%2Fbrowse%2FONA-"
}
gbnum() {
	BRANCH_NO=$1
	if [ -z "$BRANCH_NO" ]
	then
		glb
		read BRANCH_NO
	fi
	echo `git branch --list | tr -d " *" | sed -n "${BRANCH_NO}p"`
}
gco() {
	PREV_BRANCH=`gbname`
	re='^[0-9]+$'
	case $1 in
	'')
		~/clickmenu.sh `git -c color.ui=always branch --list | tr -d " *"`
		;;
	[0-9]|[0-9][0-9])
		git checkout "`gbnum $1`"
		;;
	d|dev)
		git checkout develop
		;;
	-)
		git checkout "$OLD_GBNAME"
		;;
	--)
		git checkout -- "$2"
		;;
	*)
		git checkout "$1"
		;;
	esac
	if [[ $? -eq 0 ]]; then
		CURR_BRANCH=`gbname`
		if [ "$CURR_BRANCH" != "$PREV_BRANCH" ]; then
			export OLD_GBNAME=$PREV_BRANCH
		fi
	fi
}


gbd() {
	for var in "$@"; do
		git branch -D `gbnum $var`
	done
}

gstash() {
	git stash save "$1"
}

r2d() {
	gco titan-release/v$1
	git pull
	gco d
	git pull
	gbn chore/jon-merge-release-$2
	git merge titan-release/v$1
}
