# ============================================================
# Final Configuration & Tool Initialization
# ============================================================

# Color settings
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# z.lua initialization
if [[ -f "$HOME/.local/bin/z.lua" ]]; then
    if command -v lua &>/dev/null; then
        eval "$(lua "$HOME/.local/bin/z.lua" --init zsh)"
    else
        echo "[warn] z.lua: lua not found in PATH" >&2
    fi
fi

# fzf key bindings
if command -v fzf &>/dev/null; then
	source <(fzf --zsh)
fi

# macOS specific initialization
if [[ "$OSTYPE" == "darwin"* ]]; then
    hidutil property --set '{"CapsLockDelayOverride":0}' &>/dev/null
fi

# Load confidential configurations (if exist)
[[ -f "$HOME/.config/zsh/cc.zsh" ]] && source "$HOME/.config/zsh/cc.zsh"
[[ -f "$HOME/.config/zsh/mewtant.zsh" ]] && source "$HOME/.config/zsh/mewtant.zsh"

# Key bindings
# Alt+E: Open nvim
bindkey -e
bindkey -s '\ee' 'nvim\n'
# Alt+I: Edit command in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey '\ei' edit-command-line

# Emacs keymap
bindkey "\eb" backward-word
bindkey "\ef" forward-word
