# ============================================================
# Aliases
# ============================================================

# ansible
alias an='ansible'
alias ap='ansible-playbook'

# ci
alias ci='git add -A && git amend && git push -f'

# dir
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# modern unix tools
alias cat='bat'
alias ll='lsd -al'
alias vi='vim'
if command -v nvim &>/dev/null; then
    alias vi='nvim'
fi
alias which='type'

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

# cursor
alias c='cursor'

# kubernetes
alias k='kubectl'
kctx() {
    echo "Current config: $KUBECONFIG"
    kubectl config current-context
}
alias kprod='export KUBECONFIG=~/.kube/prod.config; echo "🟡Switched to prod"'
alias ktest='export KUBECONFIG=~/.kube/test.config; echo "🔵Switched to test"'

# go
alias goci='golangci-lint run --config $HOME/.data/.golangci.yml'
alias gostrict='golangci-lint run --config $HOME/.data/.golangci-strict.yml'
alias fmt='goimports -w . && go mod tidy'
alias fmtf='gofumpt -l -w . && go mod tidy'
alias fmts='gosimports -w . && go mod tidy'
alias gocc='fmt && goci --allow-parallel-runners'
alias goss='fmtf && fmts && goci --allow-parallel-runners'
alias gdv='godotenv'
alias gt='APP_ENV=dev go test --cover --race ./...'
alias gts='APP_ENV=dev SKIP_TEST=true go test --cover --race ./...'

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
        # OCR (requires: brew install tesseract pngpaste)
        alias pocr='pngpaste - | tesseract stdin stdout'
        ;;
esac

