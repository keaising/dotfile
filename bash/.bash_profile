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
alias j='sudo journalctl'
alias d='docker'
alias dc='docker compose'
alias ts='sudo tailscale'
alias vi=vim

# settings
export VISUAL=vim
export EDITOR=vim
# go env
export GOPROXY=https://goproxy.cn
export GOPATH=$HOME/code/go

# prompt
PS1_PROMPT() {
  local e=$?
  (( e )) && printf "\033[0;31m $e> \033[0m\n" || printf "$ "
  return $e
}
PS1='\[\e[0m\]\u@\h:\w\[\e[0m\]'
PS1="$PS1"'$(PS1_PROMPT)'

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

set_timezone() {
	sudo timedatectl set-timezone Asia/Shanghai
}

add_no_login_user() {
	sudo groupadd $1
	sudo useradd --system \
	    --gid $1 \
	    --create-home \
	    --home-dir /var/lib/$1 \
	    --shell /usr/sbin/nologin \
	    $1
}

add_user() {
	sudo groupadd $1
	sudo useradd \
		--gid $1
		$1

	usermod -aG sudo $1
}

install_docker() {
	curl -fsSL https://get.docker.com -o get-docker.sh

	sudo sh get-docker.sh

	sudo groupadd docker
	sudo usermod -aG docker $USER

	newgrp docker
	docker info
}

install_tailscale() {
	curl -fsSL https://tailscale.com/install.sh | sh
}
