if [[ "$OSTYPE" == "darwin"* ]]; then
	# Homebrew
	eval "$(/opt/homebrew/bin/brew shellenv)"
	# Load antidote
	source $(brew --prefix)/opt/antidote/share/antidote/antidote.zsh
else
	source ~/.antidote/antidote.zsh
fi

# initialize plugins
# antidote load

# Load plugins
source ~/.zsh_plugins.zsh
