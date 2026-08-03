# ============================================================
# Final Configuration & Tool Initialization
# ============================================================

# Color settings
export CLICOLOR=1
# LSCOLORS drives BSD ls; LS_COLORS drives GNU tools and the completion menu.
export LSCOLORS=ExFxBxDxCxegedabagacad
export LS_COLORS='di=1;34:ln=1;36:so=1;35:pi=33:ex=1;32:bd=1;33:cd=1;33:su=1;31:sg=1;31:tw=1;34:ow=1;34'

# z.lua initialization
if [[ -f "$HOME/.local/bin/z.lua" ]]; then
    if command -v lua &>/dev/null; then
        eval "$(lua "$HOME/.local/bin/z.lua" --init zsh)"
        # z.lua defines `alias z=_zlua`, and an alias outranks a function, which
        # would shadow the z() wrapper in 06-functions.zsh.
        unalias z 2>/dev/null
    else
        echo "[warn] z.lua: lua not found in PATH" >&2
    fi
fi

# fzf key bindings
if command -v fzf &>/dev/null; then
	source <(fzf --zsh)
fi

# hidutil lives in .zprofile — it is a system-wide one-shot, not per-shell.
# Private configs are picked up by the *.zsh glob in .zshrc; sourcing them here
# too would load them twice.

# Key bindings (keymap is set to emacs in 00-init.zsh)
# Alt+E: Open nvim
bindkey -M emacs -s '\ee' 'nvim\n'
# Alt+I: Edit command in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey -M emacs '\ei' edit-command-line

# Up/Down search history by what is already typed, instead of walking every entry
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey -M emacs '^[[A' up-line-or-beginning-search
bindkey -M emacs '^[[B' down-line-or-beginning-search
bindkey -M emacs '^[OA' up-line-or-beginning-search
bindkey -M emacs '^[OB' down-line-or-beginning-search
