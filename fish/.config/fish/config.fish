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
alias exa=eza
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
# set -gx GOPROXY https://goproxy.cn,direct
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
set -Ux GEM_HOME "$HOME/code/gems"

# Added by n-install (see http://git.io/n-install-repo).
set -Ux N_PREFIX "$HOME/code/n"
# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"

# pyenv
set -Ux PYENV_ROOT "$HOME/.pyenv"
command -v pyenv >/dev/null && eval (pyenv init - | source)

alias yay='yay --noconfirm'

# rust
set -Ux RUST_BACKTRACE 1

# misc
set -Ux XDG_CONFIG_HOME "$HOME/.config"
set -Ux XDG_CACHE_HOME "$HOME/.cache"
set -Ux VISUAL nvim
set -Ux EDITOR nvim
set -Ux GIT_EDITOR nvim
set -Ux LANG "en_US.UTF-8"
set -Ux LC_CTYPE "en_US.UTF-8"
set -Ux LC_ALL "en_US.UTF-8"
set -Ux GPG_TTY (tty)
# for tmux in wezterm, kitty
# set -x TERM "screen-256color"

set -l _paths \
    /usr/local/go/bin \
    $HOME/code/go/bin \
    $HOME/.local/share/nvim/mason/bin \
    $HOME/code/gems/bin \
    $GOPATH/bin \
    $N_PREFIX/bin \
    $HOME/.cargo/bin \
    $PYENV_ROOT/bin \
    $HOME/.dotnet/tools \
    # macOS JDK
    /usr/local/opt/openjdk/bin \
    /opt/homebrew/opt/openjdk/bin \
    # CUDA: Ubuntu/Debian
    /usr/local/cuda/bin \
    # CUDA: Arch
    /opt/cuda/bin \
    $HOME/.local/bin \
    /opt/homebrew/bin \
    /opt/homebrew/sbin \
    /usr/local/bin \
    /usr/local/sbin \
    /usr/local \
    /usr/bin \
    /usr/sbin

# prepend path to $PATH in reversed order
for path in $_paths[-1..1]
    # only add to $PATH when path exist and path not in $PATH
    test -d "$path" &&
        fish_add_path --move --path --prepend "$path"
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

# from /usr/share/fish/functions/cd.fish, add fzf for search
function cd --description "Change directory"
    set -l MAX_DIR_HIST 25

    # Skip history in subshells.
    if status --is-command-substitution
        builtin cd $argv
        return $status
    end

    # Avoid set completions.
    set -l previous $PWD

    if test "$argv" = -
        if test "$__fish_cd_direction" = next
            nextd
        else
            prevd
        end
        return $status
    end

    if test (count $argv) -eq 0
        # search
        set -l dir (fd --type d --hidden --max-depth 3 --follow . "$HOME/code" | fzf)
        [ -d $dir ] && builtin cd $dir >/dev/null
    else
        # path exist
        builtin cd $argv 2>/dev/null
        # path not exist, z.lua
        if [ $status -ne 0 ] && type -q z
            z $argv
        end
    end

    set -l cd_status $status

    if test $cd_status -eq 0 -a "$PWD" != "$previous"
        set -q dirprev
        or set -l dirprev
        set -q dirprev[$MAX_DIR_HIST]
        and set -e dirprev[1]

        # If dirprev, dirnext, __fish_cd_direction
        # are set as universal variables, honor their scope.

        set -U -q dirprev
        and set -U -a dirprev $previous
        or set -g -a dirprev $previous

        set -U -q dirnext
        and set -U -e dirnext
        or set -e dirnext

        set -U -q __fish_cd_direction
        and set -U __fish_cd_direction prev
        or set -g __fish_cd_direction prev
    end

    return $cd_status
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
    set -gx https_proxy $px3_proxy
    set -gx http_proxy $px3_proxy
    set -gx all_proxy $px3_proxy
    echo "set proxy to $px3_proxy"
end

function px5
    setpx "10.10.43.5:1080"
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

function open
    # macOS
    if test (uname) = Darwin
        /usr/bin/open $argv
        return
    end

    # WSL
    if uname -r | grep -iq wsl
        wslview $argv
        return
    end

    # Arch Linux
    if uname -r | grep -iq arch
        xdg-open $argv &>/dev/null 2>&1
        return
    end
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
            test -n "$argv[1]" && set port $argv[1]

            set name (basename (dirname $PWD))_(basename $PWD)
            test -n "$argv[2]" && set name $argv[2]

            echo container: $name http://127.0.0.1:$port/lab
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
    set ext zip rar bz2 gz tar tbz2 tgz Z 7z xz exe tar.bz2 tar.gz tar.xz lzma
    if test -z "$argv"
        # display usage if no parameters given
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz|lzma>"
        return
    end
    if not test -f "$argv"
        echo $argv "- file does not exist"
        return
    end
    switch $argv
        case "*.$ext[1]"
            unzip ./$argv
        case "*.$ext[2]"
            unrar x -ad ./$argv
        case "*.$ext[3]"
            bunzip2 ./$argv
        case "*.$ext[4]"
            gunzip ./$argv
        case "*.$ext[5]"
            tar xvf ./$argv
        case "*.$ext[6]"
            tar xvjf ./$argv
        case "*.$ext[7]"
            tar xvzf ./$argv
        case "*.$ext[8]"
            uncompress ./$argv
        case "*.$ext[9]"
            7z x ./$argv
        case "*.$ext[10]"
            unxz ./$argv
        case "*.$ext[11]"
            cabextract ./$argv
        case "*.$ext[12]"
            tar xvjf ./$argv
        case "*.$ext[13]"
            tar xvzf ./$argv
        case "*.$ext[14]"
            tar xvJf ./$argv
        case "*.$ext[15]"
            unlzma ./$argv
        case '*'
            echo "extract: $argv - unknown archive method"
    end
end

# starship
set -x STARSHIP_CONFIG $HOME/.config/fish/starship.toml
if [ -e $STARSHIP_CONFIG ]
    if not type -q starship
        echo "Installing starship ..."
        sh -c "$(curl -fsSL https://starship.rs/install.sh)"
    end
    starship init fish | source
end

# z.lua
set -x ZLUA_FILE $HOME/.config/fish/z.lua
if [ -e $ZLUA_FILE ]
    set -gx _ZL_MATCH_MODE 1
    set -gx _ZL_CMD z
    set -gx _ZL_ADD_ONCE 1
    source (lua $ZLUA_FILE --init fish | psub)
end

# fzf
if type -q fzf
    set -x FZF_DEFAULT_OPTS '--height 60% --layout=reverse --border'
    function fish_user_key_bindings
        fzf_key_bindings
    end
end


# os
switch (uname)
    case Linux
        alias j='sudo journalctl'
        alias s='sudo systemctl'
        type -q pacman && alias i='sudo pacman -S'
        type -q apt && alias i='sudo apt install'
        alias ts='sudo tailscale'

        # macOS guest in qemu
        alias macos='cd $HOME/code/github.com/keaising/quickemu && quickemu --vm macos-big-sur.conf'

    case Darwin
        set -gx HOMEBREW_NO_AUTO_UPDATE 1
        set -gx HOMEBREW_NO_BOTTLE_SOURCE_FALLBACK 1
        alias i='brew install'
        alias ic='brew install --cask'
        alias dnsm='sudo brew services restart dnsmasq'
        alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
        alias ts="sudo /Applications/Tailscale.app/Contents/MacOS/Tailscale"
        set -Ux SSH_AUTH_SOCK "~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock"

        # ocr, source: https://www.kawabangga.com/posts/4876
        # brew install tesseract pngpaste
        alias pocr='pngpaste - | tesseract stdin stdout'
end


# confidential
[ -e $HOME/.config/fish/cc.fish ] && source $HOME/.config/fish/cc.fish


# key bindings
bind \ee "nvim; commandline -f repaint"
bind \ei edit_command_buffer
