# ci
alias trigger='git amend && git push -f'

# dir
alias .='cd .'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ll='ls -al'
alias to='j'
alias jf='j -I'
alias jb='j -b'

# docker
alias d='docker'
alias dc='docker-compose'
alias dcup='docker-compose up'
alias da='docker attach'

# git
alias gd='git dif'
alias ga='git add .'
alias gc='git commit -m'
alias g='gitui'

# proxy
alias pl='https_proxy=http://127.0.0.1:1080 http_proxy=http://127.0.0.1:1080 all_proxy=socks5://127.0.0.1:1081 '
alias pi='https_proxy=http://10.10.43.3:1080 http_proxy=http://10.10.43.3:1080 all_proxy=socks5://10.10.43.3:1080 '

# rust
alias cb='cargo build'
alias cr='cargo run'
alias cf='cargo fmt'
alias ct='cargo test'
alias e='exercism'

# script
alias python='python3'
alias pip='pip3'
# alias z='zerotier-cli'
alias y='yarn'

# tmux
alias tmux='tmux'
alias t='tmux'
alias ta='tmux attach-session -t'
alias tn='tmux new -s'
alias tka='tmux kill-session -a'
alias tk='tmux kill-seesion -t'

# vim
alias vi='nvim'
alias v='nvim'

# others
alias now='date +%s'
alias sz="source $HOME/.zshrc"
alias j='z'
# alias rg='rg --column --line-number --hidden --sort path --no-heading --color=always --smart-case -- '

# macos only
alias refresh-dns='sudo killall -HUP mDNSResponder'

