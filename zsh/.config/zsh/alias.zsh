# dir
alias .='cd .'
alias ..='cd ..'
alias ...='cd ../..'
alias ll='ls -al'
alias to='jump'

# rust
alias cb='cargo build'
alias cr='cargo run'

# git
alias gd='git dif'
alias ga='git add .'
alias gc='git commit -m'

# docker
alias d='docker'
alias dc='docker-compose'
alias dcup='docker-compose up'
alias da='docker attach'

# vim
alias vi='nvim'
alias v='nvim'

# script
alias python='python3'
alias pip='pip3'
alias z='zerotier-cli'
alias y='yarn'

alias now='date +%s'
alias sz="source $HOME/.zshrc"

# alias rg='rg --column --line-number --hidden --sort path --no-heading --color=always --smart-case -- '

# proxy
alias pl='https_proxy=http://127.0.0.1:1080 http_proxy=http://127.0.0.1:1080 all_proxy=socks5://127.0.0.1:1081 '
alias pi='https_proxy=http://10.10.43.3:1080 http_proxy=http://10.10.43.3:1080 all_proxy=socks5://10.10.43.3:1080 '

# tmux
alias t='tmux'
alias ta='tmux attach-session -t'
alias tn='tmux new -s'
alias tka='tmux kill-session -a'
alias tk='tmux kill-seesion -t'

# macos only
alias refresh-dns='sudo killall -HUP mDNSResponder'

