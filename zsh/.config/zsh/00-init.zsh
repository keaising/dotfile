# Must run before any bindkey: zsh picks viins when $EDITOR/$VISUAL matches *vi*,
# and a later `bindkey -e` would strand every binding made against viins.
bindkey -e

if [[ "$OSTYPE" == "darwin"* ]]; then
	# Homebrew
	eval "$(/opt/homebrew/bin/brew shellenv)"
	# Load antidote
	source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh
else
	source ~/.antidote/antidote.zsh
fi

# Use `antidote load` rather than sourcing the static file directly: it rebuilds
# when .zsh_plugins.txt changes or when the plugin cache under ~/Library/Caches is wiped.
antidote load
