export PS1="\W \u\$ "
export BASH_SILENCE_DEPRECATION_WARNING=1
alias o=open
alias s='open -a Sublime\ Text'
alias glb='git -c color.ui=always branch --list --sort=committerdate | tr -d " *" | awk '\''{printf("%d %s\n", NR, $0)}'\'' 1>&2'
alias gbn='git checkout -b'
alias gp='git push -u'
alias gd='git diff'
alias gl='git log'
alias gc='git commit'
alias gbd='git branch -D'
alias gsu='git submodule update --recursive'
alias gbname='git symbolic-ref --short -q HEAD'
alias g='./gradlew'

gs() {
	git status "$@"
	echo "Assume unchanged files:"
	git ls-files -v | grep "^[a-z]"
}

gpr() {
	gp && open "$(git config --get remote.origin.url | sed s_git@_http://_ | sed 's_\.git__' | sed 's_com:_com/_' | sed 's_org:_org/_')/compare/$(gbname)?expand=1"
}
gco() {
	if [[ $1 =~ ^[0-9]+$ ]] ; then
		git checkout $(git branch --list --sort=committerdate | tr -d " *" | awk "NR == $1")
	else
		git checkout "$@"
	fi
}
geb() {
	BN=$(gbname)
	gco ${1:-develop}
	git pull
	gbd $BN
}

sbp() {
	s -W -n /Users/jonathan/.bash_profile
	source /Users/jonathan/.bash_profile
}

export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home/"

export ANDROID_HOME=~/Library/Android/sdk
export ANDROID_SDK_ROOT=~/Library/Android/sdk
export ANDROID_AVD_HOME=~/.android/avd
