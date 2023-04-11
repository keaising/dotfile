# A pure zsh config can be use in bare machine

# alias --- {{{

# ansible
alias an='ansible'
alias ap='ansible-playbook'

# ci
alias trigger='git add -A && git amend && git push -f'

# dir
alias .='cd .'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ll='exa -al --group-directories-first'
alias ls=exa
alias vi=nvim

# docker
alias d='docker'
alias dc='docker compose'
alias dr='docker run --rm'
alias dcup='docker compose up'
alias dil='docker image ls'
alias dcl='docker container ls -a'
alias drm='docker rm'
alias drmi='docker rmi'
da() {
	docker exec -it $1 /bin/bash
}

# git
alias gd='git dif'
alias ga='git add .'
alias gc='git commit -m'
alias g='gitui'
alias glp='gl -p'
alias glm='gl -m'
alias glb='gl -b'
alias glc='gl -c'

#jabba
alias jb='jabba'

# proxy
alias pl='https_proxy=http://127.0.0.1:1080 http_proxy=http://127.0.0.1:1080 all_proxy=socks5://127.0.0.1:1081 '
alias pi='https_proxy=http://10.10.43.6:1080 http_proxy=http://10.10.43.6:1080 all_proxy=http://10.10.43.6:1080 '

# rust
alias cb='cargo build'
alias cr='cargo run'
alias cf='cargo fmt'
alias ct='cargo test'
alias e='exercism'

# script
alias python='python3'
alias pip='pip3'
alias sa='source ./venv/bin/activate'

# ocr, source: https://www.kawabangga.com/posts/4876
# brew install tesseract pngpaste
alias pocr='pngpaste - | tesseract stdin stdout'

# tmux
alias t='tmux'
alias ta='tmux attach-session -t'
alias tn='tmux new -s'
alias tka='tmux kill-session -a'
alias tk='tmux kill-seesion -t'
alias tx='tmuxp'

# others
alias now='date +%s'
alias sz="source $HOME/.zshrc"
# alias rg='rg --column --line-number --hidden --sort path --no-heading --color=always --smart-case -- '
alias dfp='datahub-field-parse'
alias vvv='nvim --headless "+Lazy! sync" +qa'

# }}}

# golang --- {{{
# golang config in macOS
# export GOROOT=/usr/local/go
export GOPATH=$HOME/code/go
export GOPROXY=https://goproxy.cn,direct
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

alias goci='golangci-lint run --config $HOME/.data/.golangci.yml'
alias gostrict='golangci-lint run --config $HOME/.data/.golangci-strict.yml'
alias fmt='goimports -w . && go mod tidy'
alias fmtf='gofumpt -l -w . && go mod tidy'
alias fmts='gosimports -w . && go mod tidy'
alias gocc='fmt && goci --allow-parallel-runners'
alias goss='\
	fmtf &&\
	fmts &&\
	goci --allow-parallel-runners'
alias gdv='godotenv'
alias gt='APP_ENV=dev go test --cover --race ./...'
alias gts='APP_ENV=dev SKIP_TEST=true go test --cover --race ./...' # skip some test

glone() {
	clone $1 | tee /tmp/goclone
	cd $(cat /tmp/goclone | head -n 1 | awk '{print $4}')
}

v() {
	govulncheck ./... >/tmp/govulncheck 2>&1
	err_code=$?
	[[ $err_code -ne 0 ]] && cat /tmp/govulncheck
	echo -n "" >/tmp/govulncheck
}

# }}}

# config --- {{{
# env
export VISUAL=nvim
export EDITOR=vim
export GIT_EDITOR="${EDITOR}"
export LANG="en_US.UTF-8"
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# if line ends without lf, show this mark rather than '%'
export PROMPT_EOL_MARK='⏎'

# gem
export GEM_HOME="$HOME/code/gems"

# Added by n-install (see http://git.io/n-install-repo).
export N_PREFIX="$HOME/code"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"

# jabba
export JABBA_HOME="$HOME/code/jabba"
[ -s "$JABBA_HOME/jabba.sh" ] && source "$JABBA_HOME/jabba.sh"

# rust
RUST_BACKTRACE=1

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# for tmux in wezterm, kitty
export TERM="screen-256color"
# GPG
export GPG_TTY=$(tty)

# WSL (aka Bash for Windows) doesn't work well with BG_NICE
[ -d "/mnt/c" ] && [[ "$(uname -a)" == *Microsoft* ]] && unsetopt BG_NICE

# path
_enabled_paths=(
	"$HOME/.local/bin"                  # my own tools
	"$HOME/code/go/bin"                 # go
	"$HOME/.local/share/nvim/mason/bin" # nvim lsp servers/linters
	"$HOME/code/gems/bin"               # gems
	"$N_PREFIX/bin"                     # n
	"$HOME/.cargo/bin"                  # rust
	"$PYENV_ROOT/bin"                   # python

	"/usr/bin"
	"/usr/sbin"
	"/usr/local" # for go on macOS
	"/usr/local/bin"
	"/usr/local/sbin"

	"/usr/local/opt/openjdk/bin" # macOS JDK

	"/usr/local/cuda/bin" # CUDA: Ubuntu/Debian
	"/opt/cuda/bin"       # CUDA: Arch
)

for _enabled_path in $_enabled_paths[@]; do
	# only add to $PATH when path exist and path not in $PATH
	[[ -d "${_enabled_path}" ]] &&
		[[ ! :$PATH: == *":${_enabled_path}:"* ]] &&
		PATH="$PATH:${_enabled_path}"
done

# pyenv
[[ -x "$(command -v pyenv)" ]] && eval "$(pyenv init -)"

# tab completion ignore case
# https://superuser.com/questions/1092033/how-can-i-make-zsh-tab-completion-fix-capitalization-errors-for-directories-and
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# History config
HISTSIZE=10000
SAVEHIST=10000

HISTFILE=$HOME/.zsh_history
setopt append_history
setopt share_history
setopt long_list_jobs
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt hist_verify
setopt hist_no_store
setopt interactivecomments
zstyle ':completion:*' rehash true
# }}}

# function --- {{{

cd() {
	if [[ "$#" != 0 ]]; then
		builtin cd "$@"
		return
	fi
	local dir="$(printf '%s\n' $(fd --type d --hidden --follow . "$HOME/code" | fzf))"
	[[ ${#dir} != 0 ]] || return 0
	builtin cd "$dir" &>/dev/null
}

rmf() {
	fd --hidden --follow | fzf | xargs rm -rf
}

mc() {
	mkdir -p -- "$1" && cd -P -- "$1"
}

hostip() {
	export HOST_IP="$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}' | head -n 1)"
	echo $HOST_IP
}

setpx() {
	export https_proxy=http://$1
	export http_proxy=http://$1
	export all_proxy=socks5://$1
	echo "set proxy to $1"
}

px1() {
	setpx 127.0.0.1:1080
}

px3() {
	px3_proxy=socks5://10.10.43.3:1080
	export https_proxy=$px3_proxy
	export http_proxy=$px3_proxy
	export all_proxy=$px3_proxy
	echo "set proxy to $px3_proxy"
}

px6() {
	setpx 10.10.43.6:1080
}

px127() {
	setpx 127.0.0.1:1080
}

nopx() {
	export https_proxy=
	export http_proxy=
	export all_proxy=
	echo "set proxy to nil"
}

# new note
note() {
	port=$1
	case $port in
	l | ls) # ls
		docker container ls | grep jupyter
		;;
	k | ki | kill) # kill
		docker container ls | grep $2 | awk '{ print $1 }' | xargs docker container kill
		;;
	*) # new
		[ -z "$port" ] && port=8888
		name=$2
		[ -z "$name" ] && name=$(basename $(dirname $PWD))_$(basename $PWD)
		docker run \
			-d --rm \
			--name "$name" \
			-p "$port":8888 \
			-v "$PWD":/home/jovyan \
			jupyter/scipy-notebook \
			jupyter-lab --NotebookApp.token= --NotebookApp.password=
		open "http://127.0.0.1:${port}/lab"
		;;
	esac
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

# macos only
dns() {
	for i in {1..$1}; do
		sudo killall -HUP mDNSResponder
	done
}

# --- }}}

# keymap --- {{{

bindkey -e

autoload -U edit-command-line
zle -N edit-command-line
bindkey '\ei' edit-command-line
bindkey '^n' autosuggest-accept # auto suggestion

# C-A: beginning-of-line
# C-E: end-of-line
# C-B: backward-char
# C-F: forward-char
# A-B: backward-word
# A-F: forward-word
# C-W: delete word before
# A-D: delete word after
# A-D: delete word after
# C-D: delete char after
# C-U: clear the entire line
# C-K: Clear the characters on the line after the current cursor position

# shortcuts
bindkey -s '\ee' 'nvim \n'

# --- }}}
