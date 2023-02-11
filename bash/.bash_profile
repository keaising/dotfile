# path
_enabled_paths=(
	"/usr/local/go/bin"
	"/usr/sbin"
	"/usr/local"
	"/usr/local/bin"
	"/usr/local/sbin"
	"$HOME/code/go/bin"
)

for _enabled_path in ${_enabled_paths[@]}; do
	# only add to $PATH when path exist and path not in $PATH
	[[ -d "${_enabled_path}" ]] &&
		[[ ! :$PATH: == *":${_enabled_path}:"* ]] &&
		PATH="$PATH:${_enabled_path}"
done

# alias
alias .='cd .'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias i='sudo apt install'
alias ll='ls -al'
alias s='sudo systemctl'
alias j='sudo journal'
alias d='docker'
alias dc='docker compose'
alias ts='sudo tailscale'

# settings
export VISUAL=vim
export EDITOR=vim
# go env
export GOPROXY=https://goproxy.cn
export GOPATH=$HOME/code/go

# functions
mc() {
	mkdir -p -- "$1" && cd -P -- "$1"
}

extract() {
	if [ -f $1 ]; then
		case $1 in
			*.tar.bz2) tar xjf $1 ;;
			*.tar.gz) tar xzf $1 ;;
			*.tar.xz) tar xf $1 ;;
			*.bz2) bunzip2 $1 ;;
			*.rar) unrar e $1 ;;
			*.gz) gunzip $1 ;;
			*.tar) tar xf $1 ;;
			*.tbz2) tar xjf $1 ;;
			*.tgz) tar xzf $1 ;;
			*.zip) unzip $1 ;;
			*.Z) uncompress $1 ;;
			*.7z) 7z x $1 ;;
			*) echo "'$1' cannot be extracted via extract()" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}
