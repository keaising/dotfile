# ============================================================
# Final Configuration & Tool Initialization
# ============================================================

# Color settings
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

# z.lua initialization
if [[ -f "$HOME/.local/bin/z.lua" ]]; then
    eval "$(lua "$HOME/.local/bin/z.lua" --init zsh)"
fi

# fzf key bindings
if command -v fzf &>/dev/null; then
    # Load fzf key bindings if available
    [[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
    # Or from Homebrew
    [[ -f $(brew --prefix)/opt/fzf/shell/key-bindings.zsh ]] && \
        source $(brew --prefix)/opt/fzf/shell/key-bindings.zsh
    [[ -f $(brew --prefix)/opt/fzf/shell/completion.zsh ]] && \
        source $(brew --prefix)/opt/fzf/shell/completion.zsh
fi

# macOS specific initialization
if [[ "$OSTYPE" == "darwin"* ]]; then
    # Disable CapsLock delay when switching Input Method
    if [[ ! -f "$HOME/.cache/capslock_delay_disabled" ]]; then
        hidutil property --set '{"CapsLockDelayOverride":0}' &>/dev/null
        mkdir -p "$HOME/.cache"
        touch "$HOME/.cache/capslock_delay_disabled"
    fi
fi

# Load confidential configurations (if exist)
[[ -f "$HOME/.config/zsh/cc.zsh" ]] && source "$HOME/.config/zsh/cc.zsh"
[[ -f "$HOME/.config/zsh/mewtant.zsh" ]] && source "$HOME/.config/zsh/mewtant.zsh"

# Key bindings
# Alt+E: Open nvim
bindkey -s '\ee' 'nvim\n'
# Alt+I: Edit command in editor
autoload -z edit-command-line
zle -N edit-command-line
bindkey '\ei' edit-command-line
