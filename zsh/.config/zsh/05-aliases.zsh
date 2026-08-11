# ============================================================
# Aliases
# ============================================================

# ansible
alias an='ansible'
alias ap='ansible-playbook'

# ci: amend everything into the last commit and force-push. Guarded because a
# stray run on a shared branch rewrites other people's commits.
ci() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null) || {
        echo "ci: not on a branch" >&2
        return 1
    }
    case "$branch" in
        main|master|develop|release/*)
            echo "ci: refusing to amend and force-push on '$branch'" >&2
            return 1
            ;;
    esac
    git add -A && git commit --amend --no-edit && git push --force-with-lease
}

# dir
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# modern unix tools
command -v bat &>/dev/null && alias cat='bat'
if command -v lsd &>/dev/null; then
    alias ll='lsd -al'
else
    alias ll='ls -al'
fi
alias vi='vim'
if command -v nvim &>/dev/null; then
    alias vi='nvim'
fi


# docker
alias d='docker'
alias dc='docker compose'
alias dr='docker run --rm'
alias dcup='docker compose up'
alias dil='docker image ls'
alias dcl='docker container ls -a'
alias drm='docker rm'
alias drmi='docker rmi'

# git
alias ga='git add .'
alias gc='git commit -m'
alias g='gitui'
alias glm='git_open'

# tmux
alias t='tmux'
alias ta='tmux attach-session -t'
alias tn='tmux new-session -s'
alias tka='tmux kill-session -a'
alias tk='tmux kill-session -t'
alias tx='tmuxp'

alias c='claude --dangerously-skip-permissions'
alias w='wt'

# kubernetes
alias k='kubectl'
kctx() {
    echo "Current config: $KUBECONFIG"
    kubectl config current-context
}
alias kprod='export KUBECONFIG=~/.kube/prod.config; echo "🟡Switched to prod"'
alias ktest='export KUBECONFIG=~/.kube/test.config; echo "🔵Switched to test"'

# OS-specific aliases
case "$OSTYPE" in
    linux*)
        alias j='sudo journalctl'
        alias s='sudo systemctl'
        command -v pacman &>/dev/null && alias i='sudo pacman -S'
        command -v apt &>/dev/null && alias i='sudo apt install'
        alias ts='sudo tailscale'
        ;;
    darwin*)
        alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
        alias ts="sudo /Applications/Tailscale.app/Contents/MacOS/Tailscale"
        alias brewup='sudo -v && brew update && brew upgrade --greedy --no-ask && brew cleanup'
        # OCR (requires: brew install tesseract pngpaste)
        alias pocr='pngpaste - | tesseract stdin stdout'
        # ghostty: launch with tmux keybindings
        alias gt='open -na Ghostty.app --args --config-file="$HOME/.config/ghostty/tmux-keybinds.conf"'
        ;;
esac

