# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585858"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey '^F' autosuggest-accept

# zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_HIGHLIGHT_MAXLENGTH=512

# Starship prompt
eval "$(starship init zsh)"
