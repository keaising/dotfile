# edit in vim
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
bindkey '\ei' edit-command-line
# bindkey -M vicmd v edit-command-line



# move cursor
bindkey '\eH' backward-char
bindkey '\eL' forward-char
bindkey '\eJ' down-line-or-history
bindkey '\eK' up-line-or-history
bindkey '\eh' backward-word
bindkey '\el' forward-word
bindkey '\ej' beginning-of-line
bindkey '\ek' end-of-line

bindkey '\e[1;3D' backward-word
bindkey '\e[1;3C' forward-word
bindkey '\e[1;3A' beginning-of-line
bindkey '\e[1;3B' end-of-line



# shortcuts
bindkey -s '\ee' 'vim .\n'
bindkey -s '\eo' 'cd ..\n'
bindkey -s '\e;' 'll\n'



# auto suggestion
autoload -U autosuggest-excute
bindkey '^\' autosuggest-excute
bindkey '^n' autosuggest-accept

# bindkey '\ev' deer
# bindkey -s '\eu' 'ranger_cd\n'
# bindkey -s '\eOS' 'vim '
