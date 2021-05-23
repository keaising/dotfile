export ZSH_CONF="$HOME/.config/zsh"

# import from secret project
source "$ZSH_CONF/cc.zsh"

source "$ZSH_CONF/alias.zsh"
source "$ZSH_CONF/golang.zsh"
source "$ZSH_CONF/config.zsh"
source "$ZSH_CONF/function.zsh"
source "$ZSH_CONF/starship.zsh"
# import z.lua
eval "$(lua $ZSH_CONF/z.lua  --init zsh)"    # ZSH 初始化

# install plugins
# source "$ZSH_CONF/zplug.zsh"
source "$ZSH_CONF/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit


# set keybinding after plugins
source "$ZSH_CONF/keymap.zsh"

# system specified configuration
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

# fzf
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
export FZF_COMPLETION_TRIGGER='ll'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# check tools
source "$ZSH_CONF/tools.zsh"

