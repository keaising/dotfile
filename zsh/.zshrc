export ZSH_CONF="$HOME/.config/zsh"

# import from secret project
source "$ZSH_CONF/cc.zsh"

source "$ZSH_CONF/vanilla.zsh"


# system specified --- {{{
if [ "$(uname 2> /dev/null)" = "Linux" ]; then
	source "$ZSH_CONF/config.linux.zsh"
	if [ $"uname -r | grep -q 'Microsoft'" ]; # if in wsl 
	then
		source "$ZSH_CONF/config.wsl.zsh"
	fi
fi

if [ "$(uname 2> /dev/null)" = "Darwin" ]; then
	source "$ZSH_CONF/config.macos.zsh"
fi
# --- }}}



# starship --- {{{
export STARSHIP_CONFIG=$HOME/.config/zsh/config.toml
if [ ! -f "`which starship`" ]; then
	echo "Installing starship ..."
	setpx
	sh -c "$(curl -fsSL https://starship.rs/install.sh)"
fi
eval "$(starship init zsh)"

# --- }}}



# plugins --- {{{
export ZINIT_PATH="$HOME/.zinit/bin"

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
fi

source "$ZINIT_PATH/zinit.zsh"

zinit light jocelynmallon/zshmarks
zinit light mafredri/zsh-async
# zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# If completion is needed, de-comment lines below.
# this will add 200ms loading time.
# zinit ice wait lucid atload"zicompinit"
# zinit light zsh-users/zsh-completions

# https://medium.com/@dannysmith/little-thing-2-speeding-up-zsh-f1860390f92
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# update zinit, only run update or first install
# zinit self-update

# ZSH_AUTOSUGGEST
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_HIGHLIGHT_STYLES[comment]=fg=245

# put these 2 lines at the end of plugins settings
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# --- }}}



# must be end --- {{{

# # fzf
export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border'
export FZF_COMPLETION_TRIGGER='ll'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# z.lua
export _ZL_MATCH_MODE=1
export _ZL_CMD=z
export _ZL_ADD_ONCE=1
eval "$(lua $ZSH_CONF/z.lua  --init zsh)" #  once enhanced)"

# check tools in the end
source "$ZSH_CONF/tools.zsh"

# --- }}

[ -s "/Users/taiga/code/jabba/jabba.sh" ] && source "/Users/taiga/code/jabba/jabba.sh"
