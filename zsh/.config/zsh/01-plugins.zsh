# zsh-autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#585858"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

bindkey -M emacs '^F' autosuggest-accept

# fast-syntax-highlighting needs no config here: `main` + `brackets` are its
# defaults, and ZSH_HIGHLIGHT_HIGHLIGHTERS belongs to zsh-syntax-highlighting.

# Starship prompt
eval "$(starship init zsh)"
