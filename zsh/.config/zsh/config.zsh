# env
export EDITOR=vim
export VISUAL=vim
export GIT_EDITOR="${EDITOR}"
export LANG="en_US.UTF-8"

# gem
export GEM_HOME="$HOME/code/gems"

# rust
RUST_BACKTRACE=1

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# for tmux in wezterm, kitty
export TERM="xterm-256color"

# WSL (aka Bash for Windows) doesn't work well with BG_NICE
[ -d "/mnt/c" ] && [[ "$(uname -a)" == *Microsoft* ]] && unsetopt BG_NICE

# path
_enabled_paths=(
	"/usr/bin"
	"/usr/local/bin"

	"$HOME/.local/bin" # normal install destination
	"$HOME/.cargo/bin" # cargo install destination

	"$HOME/code/gems/bin" # gems

	"/usr/local/opt/openjdk/bin"   # macos
	"$HOME/Library/Python/3.9/bin" # ansible
)

for _enabled_path in $_enabled_paths[@]; do
	[[ -d "${_enabled_path}" ]] && PATH="$PATH:${_enabled_path}"
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
