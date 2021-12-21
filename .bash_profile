export PS1="\W \u\$ "
alias o=open
alias s='open -a Sublime\ Text'
alias glb='git -c color.ui=always branch --list | tr -d " *" | awk '\''{printf("%d %s\n", NR, $0)}'\'' 1>&2'
alias gbn='git checkout -b'
alias gs='git status'
alias gp='git push -u'
alias gd='git diff'
alias gl='git log'
alias gc='git commit'
alias gco='git checkout'
alias gbd='git branch -D'
alias gsu='git submodule update --remote'
alias gbname='git symbolic-ref --short -q HEAD'
gpr() {
	gp && open "$(git config --get remote.origin.url | sed s_git@_http://_ | sed 's_\.git__')/compare/$(gbname)?expand=1"
}
export JAVA_HOME="/Applications/Android Studio.app/Contents/jre/Contents/Home/"
