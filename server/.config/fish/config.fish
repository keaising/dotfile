set fish_prompt_pwd_dir_length 0
set fish_greeting

# ansible
alias an='ansible'
alias ap='ansible-playbook'

# dir
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ll='exa -al --group-directories-first'
alias vi=vim
if type -q nvim
    alias vi=nvim
end
alias which=type

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
alias glp='gl -p'
alias glm='gl -m'
alias glb='gl -b'
alias glc='gl -c'

# tmux
alias t='tmux'
alias ta='tmux attach-session -t'
alias tn='tmux new-session -s'
alias tka='tmux kill-session -a'
alias tk='tmux kill-seesion -t'
alias tx='tmuxp'

# go
set -gx GOPATH $HOME/code/go
set -gx GOPROXY https://goproxy.cn,direct

# Added by n-install (see http://git.io/n-install-repo).
set -Ux N_PREFIX "$HOME/code/n"

# pyenv
set -Ux PYENV_ROOT "$HOME/.pyenv"
command -v pyenv >/dev/null && eval (pyenv init - | source)

# misc
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
set -Ux VISUAL vi
set -Ux EDITOR vi
set -Ux GIT_EDITOR vi
set -Ux LANG "en_US.UTF-8"
set -Ux LC_CTYPE "en_US.UTF-8"
set -Ux LC_ALL "en_US.UTF-8"
set -Ux GPG_TTY (tty)
# for tmux in wezterm, kitty
# set -x TERM "screen-256color"

set -l _paths \
    $HOME/.local/bin \
    $HOME/code/go/bin \
    $HOME/.local/share/nvim/mason/bin \
    $HOME/code/gems/bin \
    $GOPATH/bin \
    $N_PREFIX/bin \
    $HOME/.cargo/bin \
    $PYENV_ROOT/bin \
    /usr/bin \
    /usr/sbin \
    # for go on macOS
    /usr/local \
    /usr/local/bin \
    /usr/local/sbin \
    # macOS JDK
    /usr/local/opt/openjdk/bin \
    # CUDA: Ubuntu/Debian
    /usr/local/cuda/bin \
    # CUDA: Arch
    /opt/cuda/bin \
    # dotnet
    $HOME/.dotnet/tools

for path in $_paths
    # only add to $PATH when path exist and path not in $PATH
    test -d "$path" &&
        not contains $PATH "$path" &&
        set -x PATH $PATH "$path"
end

function mc
    mkdir -p -- $argv[1] && cd -P -- $argv[1]
end

# os
alias j='sudo journalctl'
alias s='sudo systemctl'
alias ts='sudo tailscale'
type -q apt && alias i='sudo apt install'
