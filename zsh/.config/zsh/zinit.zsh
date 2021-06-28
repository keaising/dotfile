
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
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# If completion is needed, de-comment lines below.
# this will add 200ms loading time.
zinit ice wait lucid atload"zicompinit"
zinit light zsh-users/zsh-completions

# ==================================================================
# update zinit, only run update or first install
# ==================================================================
# zinit self-update

# ==================================================================
# plugin config
# ==================================================================

# ZSH_AUTOSUGGEST
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_HIGHLIGHT_STYLES[comment]=fg=245
