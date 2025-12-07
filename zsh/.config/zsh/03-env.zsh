# XDG Base Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Editor
export VISUAL=nvim
export EDITOR=nvim
export GIT_EDITOR=nvim

# Locale
export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# GPG
export GPG_TTY=$(tty)

# Go
export GOPATH="$HOME/code/go"
# export GOPROXY=https://goproxy.cn,direct

# Node (n-install)
export N_PREFIX="$HOME/code/n"

# Mise
export MISE_ENV_FILE=".env"

# macOS specific
if [[ "$OSTYPE" == "darwin"* ]]; then
    export HOMEBREW_NO_AUTO_UPDATE=1
    export HOMEBREW_NO_BOTTLE_SOURCE_FALLBACK=1
    export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
fi

# Starship
export STARSHIP_CONFIG="$HOME/.config/zsh/starship.toml"

# z.lua
export _ZL_MATCH_MODE=1
export _ZL_CMD=z
export _ZL_ADD_ONCE=1

# fzf
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border'
