
export ZINIT_PATH="$HOME/.zinit/bin"



# ==================================================================
# Install zinit if not exist
# ==================================================================
if [ ! -f "$ZINIT_PATH/zinit.zsh" ]; then
	echo "Installing zinit ..."
	[ ! -d "$ZINIT_PATH" ] && mkdir -p "$ZINIT" 2> /dev/null
	if [ -x "$(which git)" ]; then
		setpx
		git clone https://github.com/zdharma/zinit.git $ZINIT_PATH
	else
		echo "ERROR: please install git before installation !!"
		exit 1
	fi
	if [ ! $? -eq 0 ]; then
		echo ""
		echo "ERROR: downloading zinit failed !!"
		exit 1
	fi;
	# zplug install
fi

# ==================================================================
# source zplug
# ==================================================================
source "$ZINIT_PATH/zinit.zsh"


# ==================================================================
# claim plugins
# ==================================================================
zinit light jocelynmallon/zshmarks
zinit light mafredri/zsh-async
# zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting


# ==================================================================
# update zinit, only run update or first install
# ==================================================================
# zinit self-update



# ==================================================================
# plugin config
# ==================================================================

# # theme
# autoload -U promptinit; promptinit
# # prompt -p pure
# export PURE_PROMPT_SYMBOL='Δ'
# export GIT_TERMINAL_PROMPT=1
# zstyle :prompt:pure:git:stash show yes
# # prompt_pure_state[username]=

# ZSH_AUTOSUGGEST
ZSH_AUTOSUGGEST_USE_ASYNC=1


# # ZSH_SYNTAX_HIGHLIGHT color definition
# ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
# typeset -A ZSH_HIGHLIGHT_STYLES
# ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
# ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
# ZSH_HIGHLIGHT_STYLES[default]=none
# ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=009
# ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=009,standout
# ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan,bold
# ZSH_HIGHLIGHT_STYLES[builtin]=fg=cyan,bold
# ZSH_HIGHLIGHT_STYLES[function]=fg=cyan,bold
# ZSH_HIGHLIGHT_STYLES[command]=fg=white,bold
# ZSH_HIGHLIGHT_STYLES[precommand]=fg=white,underline
# ZSH_HIGHLIGHT_STYLES[commandseparator]=none
# ZSH_HIGHLIGHT_STYLES[hashed-command]=fg=009
# ZSH_HIGHLIGHT_STYLES[path]=fg=214,underline
# ZSH_HIGHLIGHT_STYLES[globbing]=fg=063
# ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=white,underline
# ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=none
# ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=none
# ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
# ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=063
# ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=063
# ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=009
# ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=009
# ZSH_HIGHLIGHT_STYLES[assign]=none
