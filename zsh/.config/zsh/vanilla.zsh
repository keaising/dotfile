# A pure zsh config can be use in bare machine


# alias --- {{{

# ansible
alias an='ansible'
alias ap='ansible-playbook'

# ci
alias trigger='git amend && git push -f'

# dir
alias .='cd .'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ll='ls -al'
alias to='j'
alias jf='j -I'
alias jb='j -b'

# docker
alias d='docker'
alias dc='docker compose'
alias dcup='docker compose up'
alias da='docker exec -it'

# git
alias gd='git dif'
alias ga='git add .'
alias gc='git commit -m'
alias g='gitui'
alias gl='pc invoke'
alias glp='pc invoke -p'
alias glm='pc invoke -m'
alias glb='pc invoke -b'

#jabba
alias jb='jabba'

# proxy
alias pl='https_proxy=http://127.0.0.1:1080 http_proxy=http://127.0.0.1:1080 all_proxy=socks5://127.0.0.1:1081 '
alias pi='https_proxy=http://10.10.43.3:1080 http_proxy=http://10.10.43.3:1080 all_proxy=socks5://10.10.43.3:1080 '

# rust
alias cb='cargo build'
alias cr='cargo run'
alias cf='cargo fmt'
alias ct='cargo test'
alias e='exercism'

# script
alias python='python3'
alias pip='pip3'
# alias z='zerotier-cli'
alias y='yarn'

# tmux
alias tmux='tmux'
alias t='tmux'
alias ta='tmux attach-session -t'
alias tn='tmux new -s'
alias tka='tmux kill-session -a'
alias tk='tmux kill-seesion -t'

# vim
alias vi='nvim'
alias v='nvim'

# others
alias now='date +%s'
alias sz="source $HOME/.zshrc"
alias j='z'
# alias rg='rg --column --line-number --hidden --sort path --no-heading --color=always --smart-case -- '

# macos only
alias refresh-dns='sudo killall -HUP mDNSResponder'


# }}}



# golang --- {{{
# golang config in macOS
export GOROOT=/usr/local/go
export GOPATH=$HOME/code/go
export PATH=$PATH:$GOPATH/bin:$GOROOT/bin

alias goci='golangci-lint run --config $HOME/.data/.golangci.yml'
alias gostrict='golangci-lint run --config $HOME/.data/.golangci-strict.yml'
alias fmt='goimports -w . && go mod tidy'
alias gocc='fmt && goci'
alias goss='fmt && gostrict'
alias gdv='godotenv'
alias gt='APP_ENV=dev go test --cover --race ./...'
alias gr='APP_ENV=stage go run main.go'
# }}}



# config --- {{{
# env
export VISUAL=nvim
export EDITOR=vim
export GIT_EDITOR="${EDITOR}"
export LANG="en_US.UTF-8"

# gem
export GEM_HOME="$HOME/code/gems"

# Added by n-install (see http://git.io/n-install-repo).
export N_PREFIX="$HOME/code/n"

# jabba
export JABBA_HOME="$HOME/code/jabba"

# rust
RUST_BACKTRACE=1

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# for tmux in wezterm, kitty
export TERM="screen-256color"

# WSL (aka Bash for Windows) doesn't work well with BG_NICE
[ -d "/mnt/c" ] && [[ "$(uname -a)" == *Microsoft* ]] && unsetopt BG_NICE

# path
_enabled_paths=(
	"/usr/bin"
	"/usr/local/bin"

	"$HOME/.local/bin" # normal install destination
	"$HOME/.cargo/bin" # cargo install destination

	"$HOME/code/gems/bin" # gems

	"$N_PREFIX/bin" #n

	"/usr/local/opt/openjdk/bin"   # macos
	"$HOME/Library/Python/3.9/bin" # ansible
)

for _enabled_path in $_enabled_paths[@]; do
	# only add to $PATH when path exist and path not in $PATH
	[[ -d "${_enabled_path}" ]] && \
	[[ ! :$PATH: == *":${_enabled_path}:"* ]] && \
	PATH="$PATH:${_enabled_path}"
done

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
mc () {
	mkdir -p -- "$1" && cd -P -- "$1"
}

hostip () {
	export HOST_IP="$(ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}' | head -n 1)" 
	echo $HOST_IP
}

pxio () {
	export https_proxy=http://10.10.43.3:1080
	export http_proxy=http://10.10.43.3:1080
	export all_proxy=socks5://10.10.43.3:1081
	echo "set proxy to 10.10.43.3:1080"
}

px () {
	export https_proxy=http://127.0.0.1:1080
	export http_proxy=http://127.0.0.1:1080
	export all_proxy=socks5://127.0.0.1:1081
	echo "set proxy to 127.0.0.1:1080"
}

nopx () {
	export https_proxy=
	export http_proxy=
	export all_proxy=
	echo "set proxy to nil"
}

# auto set proxy
setpx () {
	ping -c 1 -q 10.10.43.3 1> /dev/null; ping1=$?
	if [ $ping1 -eq 0 ]
	then
		pxio
	else
		px
	fi
}

# --- }}}



# keymap --- {{{

autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
bindkey '\ei' edit-command-line
bindkey '^n' autosuggest-accept # auto suggestion

# move cursor
bindkey '\eH' backward-char
bindkey '\eL' forward-char
bindkey '\eJ' down-line-or-history
bindkey '\eK' up-line-or-history
bindkey '\eh' backward-word
bindkey '\el' forward-word
bindkey '\ej' beginning-of-line
bindkey '\ek' end-of-line

bindkey '\e[1;3D' backward-word
bindkey '\e[1;3C' forward-word
bindkey '\e[1;3A' beginning-of-line
bindkey '\e[1;3B' end-of-line

# shortcuts
bindkey -s '\ee' 'nvim .\n'
bindkey -s '\eo' 'cd ..\n'
bindkey -s '\e;' 'll\n'


# --- }}}
