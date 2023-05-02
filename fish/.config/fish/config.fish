set fish_prompt_pwd_dir_length 0
set fish_greeting

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
alias ll='exa -al --group-directories-first'
alias vi=nvim
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
alias tn='tmux new -s'
alias tka='tmux kill-session -a'
alias tk='tmux kill-seesion -t'
alias tx='tmuxp'

# go
set -gx GOPATH $HOME/code/go
set -gx GOPROXY https://goproxy.cn,direct
alias goci='golangci-lint run --config $HOME/.data/.golangci.yml'
alias gostrict='golangci-lint run --config $HOME/.data/.golangci-strict.yml'
alias fmt='goimports -w . && go mod tidy'
alias fmtf='gofumpt -l -w . && go mod tidy'
alias fmts='gosimports -w . && go mod tidy'
alias gocc='fmt && goci --allow-parallel-runners'
alias goss='\
	fmtf &&\
	fmts &&\
	goci --allow-parallel-runners'
alias gdv='godotenv'
alias gt='APP_ENV=dev go test --cover --race ./...'
alias gts='APP_ENV=dev SKIP_TEST=true go test --cover --race ./...' # skip some test

# gem
set -x GEM_HOME "$HOME/code/gems"

# Added by n-install (see http://git.io/n-install-repo).
set -x N_PREFIX "$HOME/code/n"

# pyenv
set -x PYENV_ROOT "$HOME/.pyenv"
command -v pyenv >/dev/null && eval (pyenv init - | source)

# jabba
set -x JABBA_HOME "$HOME/code/jabba"
if test -s "$JABBA_HOME/jabba.sh"
    source "$JABBA_HOME/jabba.sh"
end

# rust
set -x RUST_BACKTRACE 1

# misc
set -x XDG_CONFIG_HOME "$HOME/.config"
set -x XDG_CACHE_HOME "$HOME/.cache"
set -x VISUAL "nvim --clean"
set -x EDITOR "nvim --clean"
set -x GIT_EDITOR "nvim --clean"
set -x LANG "en_US.UTF-8"
set -x LC_CTYPE "en_US.UTF-8"
set -x LC_ALL "en_US.UTF-8"
set -x GPG_TTY (tty)
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
    /opt/cuda/bin

for path in $_paths
    # only add to $PATH when path exist and path not in $PATH
    test -d "$path" &&
        not contains $PATH "$path" &&
        set -x PATH $PATH "$path"
end


function hostip
    # Honors belong to ChatGPT
    # 1. 过滤出数字开头的行和 inet 开头的行
    # 2. 将第一行和第二行合并
    # 3. 过滤掉 lo 和 interface 后面的冒号，interface至少占15个字符，打印出来
    ip a \
        | awk '{if ($1 ~ /^[[:digit:]]/) {print $2} else if ($1 == "inet" && $2 !~ /^inet6/) {print $2}}' \
        | awk '{ORS = (NR%2 == 0 ? "\n" : ""); if (NR%2 == 1) {printf "%-20s", $0} else {printf "%s\n", $0}}' \
        | awk '{if ($1 ~ /^lo:/) next; sub(/:$/, "", $1); printf "%-15s %s\n", $1, $2}'
end

function cd
    if test (count $argv) -gt 0
        builtin cd $argv
        return
    end

    set dir (fd --type d --hidden --max-depth 3 --follow . "$HOME/code" | fzf)
    [ "$dir" ] || return 0
    builtin cd $dir >/dev/null
end

function glone
    [ (count $argv) -ne 1 ] && return
    clone $argv[1] | tee /tmp/goclone
    cd (cat /tmp/goclone | head -n 1 | awk '{print $4}')
end

function v
    govulncheck ./... >/tmp/govulncheck 2>&1
    [ $status -ne 0 ] && cat /tmp/govulncheck
    echo -n "" >/tmp/govulncheck
end

# ping tailscale with name
function tsping
    tailscale ping $(
        tailscale status |
            grep -v '^$' |
            grep -v '^#' |
            awk "{printf \"%-20s %-20s %10s\n\", \$1, \$2, \$5}" |
            fzf |
            awk "{print \$1}"
    )
end

function now
    if test (count $argv) -gt 0
        for arg in $argv
            date --iso-8601=seconds -d "@$arg"
        end
    else
        date --rfc-3339=seconds
        date +%s
    end
end

function rmf
    fd --hidden --follow | fzf | xargs rm -rf
end

function mc
    mkdir -p -- $argv[1] && cd -P -- $argv[1]
end

function setpx
    set -gx https_proxy http://$argv[1]
    set -gx http_proxy http://$argv[1]
    set -gx all_proxy socks5://$argv[1]
    echo "set proxy to $argv[1]"
end

function px1
    setpx 127.0.0.1:1080
end

function px3
    set px3_proxy "socks5://10.10.43.3:1080"
    set -x https_proxy $px3_proxy
    set -x http_proxy $px3_proxy
    set -x all_proxy $px3_proxy
    echo "set proxy to $px3_proxy"
end

function px6
    setpx "10.10.43.6:1080"
end

function px127
    setpx "127.0.0.1:1080"
end

function nopx
    set -e HTTPS_PROXY
    set -e HTTP_PROXY
    set -e ALL_PROXY
    echo "set proxy to nil"
end

function note
    switch $argv[1]
        case l ls # ls
            docker container ls | grep jupyter
        case k ki kill # kill
            set containers (docker container ls | grep $argv[2] | awk '{ print $1 }')
            for container in $containers
                docker container kill $container
            end
        case '*' # new
            set port 8888
            [ -n $argv[1] ] && set port $argv[1]

            set name (basename (dirname $PWD))_(basename $PWD)
            [ -n $argv[2] ] && set name $argv[2]

            docker run -d \
                --rm --name $name \
                -p $port:8888 \
                -v $PWD:/home/jovyan jupyter/scipy-notebook \
                jupyter-lab \
                --NotebookApp.token= \
                --NotebookApp.password=
            open "http://127.0.0.1:$port/lab"
    end
end

function extract
    if test -f $argv[1]
        switch $argv[1]
            case *.tar.bz2
                tar xjf $argv[1]
            case *.tar.gz
                tar xzf $argv[1]
            case *.tar.xz
                tar xf $argv[1]
            case *.bz2
                bunzip2 $argv[1]
            case *.rar
                unrar e $argv[1]
            case *.gz
                gunzip $argv[1]
            case *.tar
                tar xf $argv[1]
            case *.tbz2
                tar xjf $argv[1]
            case *.tgz
                tar xzf $argv[1]
            case *.zip
                unzip $argv[1]
            case *.Z
                uncompress $argv[1]
            case *.7z
                7z x $argv[1]
            case *
                echo "'$argv[1]' cannot be extracted via extract()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end


# starship
set -x STARSHIP_CONFIG $HOME/.config/fish/starship.toml
if [ -e $STARSHIP_CONFIG ]
    if not command -v starship >/dev/null
        echo "Installing starship ..."
        sh -c "$(curl -fsSL https://starship.rs/install.sh)"
    end
    starship init fish | source
end

# z.lua
set -x ZLUA_FILE $HOME/.config/fish/z.lua
if [ -e $ZLUA_FILE ]
    set _ZL_MATCH_MODE 1
    set _ZL_CMD z
    set _ZL_ADD_ONCE 1
    source (lua $ZLUA_FILE --init fish | psub)
end

# fzf
set -x FZF_DEFAULT_OPTS '--height 60% --layout=reverse --border'
function fish_user_key_bindings
    fzf_key_bindings
end


# os
switch (uname)
    case Linux
        alias j='sudo journalctl'
        alias s='sudo systemctl'
        alias ts='sudo tailscale'
        command -v pacman >/dev/null && alias i='sudo pacman -S'
        command -v apt >/dev/null && alias i='sudo apt install'
        alias ts='sudo tailscale'
    case Darwin
        set -x HOMEBREW_NO_AUTO_UPDATE 1
        set -x HOMEBREW_NO_BOTTLE_SOURCE_FALLBACK 1
        alias i='brew install'
        alias ic='brew cask install'
        alias dnsm='sudo brew services restart dnsmasq'
        alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
        alias ts="sudo /Applications/Tailscale.app/Contents/MacOS/Tailscale"

        # ocr, source: https://www.kawabangga.com/posts/4876
        # brew install tesseract pngpaste
        alias pocr='pngpaste - | tesseract stdin stdout'
end


# confidential
[ -e $HOME/.config/fish/cc.fish ] && source $HOME/.config/fish/cc.fish


# key bindings
bind \ee "nvim; commandline -f repaint"
