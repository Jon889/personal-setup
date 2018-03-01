export PS1="\W \u\$ "

alias device='git apply ~/device.patch'
alias undevice='git apply -R ~/device.patch'
alias glb='git -c color.ui=always branch --list | tr -d " *" | awk '\''{printf("%d %s\n", NR, $0)}'\'' 1>&2'
alias gbn='git checkout -b'
alias gs='git status'
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
	git checkout `gbnum $1`
}

gbd() {
	git branch -d `gbnum $1`
}

gstash() {
	git stash save "$1"
}
