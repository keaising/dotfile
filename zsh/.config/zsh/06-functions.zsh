# ============================================================
# Custom Functions
# ============================================================

# Measure zsh start time
timezsh() {
    for i in {1..3}; do
        /usr/bin/time zsh -i -c exit 2>&1 | grep real
    done | awk '/real/ {sum += $2; count++} END {printf "average: %.2fs\n", sum/count}'
}

# Enhanced cd with fzf and z.lua fallback
cd() {
    if [[ $# -eq 0 ]]; then
        # No arguments: use fzf to search directories
        if command -v fzf &>/dev/null && command -v fd &>/dev/null; then
            local dir=$(fd --type d --hidden --max-depth 3 --follow . "$HOME/code" | fzf)
            [[ -d "$dir" ]] && builtin cd "$dir"
        else
            builtin cd
        fi
    else
        # Try normal cd first
        builtin cd "$@" 2>/dev/null
        # If failed and z.lua is available, try z.lua
        if [[ $? -ne 0 ]] && typeset -f _zlua &>/dev/null; then
            _zlua "$@"
        fi
    fi
}

# Clone and cd into directory
glone() {
    [[ $# -ne 1 ]] && return 1
    clone "$1" | tee /tmp/goclone
    local dir=$(head -n 1 /tmp/goclone | awk '{print $4}')
    [[ -d "$dir" ]] && cd "$dir"
}

# Ping tailscale with fzf selection
tsping() {
    if ! command -v tailscale &>/dev/null || ! command -v fzf &>/dev/null; then
        echo "Requires: tailscale and fzf"
        return 1
    fi
    
    local host=$(tailscale status | \
        grep -v '^$' | \
        grep -v '^#' | \
        awk '{printf "%-20s %-20s %10s\n", $1, $2, $5}' | \
        fzf | \
        awk '{print $1}')
    
    [[ -n "$host" ]] && tailscale ping "$host"
}

# Make directory and cd into it
mc() {
    mkdir -p -- "$1" && cd -P -- "$1"
}

# Cross-platform open command
open() {
    case "$OSTYPE" in
        darwin*)
            /usr/bin/open "$@"
            ;;
        linux*)
            if [[ -n "$WSL_DISTRO_NAME" ]]; then
                wslview "$@"
            elif uname -r | grep -iq arch; then
                xdg-open "$@" &>/dev/null 2>&1
            else
                xdg-open "$@" 2>/dev/null
            fi
            ;;
    esac
}

# Extract various archive formats
extract() {
    if [[ -z "$1" ]]; then
        echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|tar.bz2|tar.gz|tar.xz|lzma>"
        return 1
    fi
    
    if [[ ! -f "$1" ]]; then
        echo "$1 - file does not exist"
        return 1
    fi
    
    case "$1" in
        *.tar.bz2|*.tbz2) tar xvjf "$1" ;;
        *.tar.gz|*.tgz)   tar xvzf "$1" ;;
        *.tar.xz)         tar xvJf "$1" ;;
        *.tar)            tar xvf "$1" ;;
        *.bz2)            bunzip2 "$1" ;;
        *.gz)             gunzip "$1" ;;
        *.zip)            unzip "$1" ;;
        *.rar)            unrar x -ad "$1" ;;
        *.Z)              uncompress "$1" ;;
        *.7z)             7z x "$1" ;;
        *.xz)             unxz "$1" ;;
        *.exe)            cabextract "$1" ;;
        *.lzma)           unlzma "$1" ;;
        *)                echo "extract: '$1' - unknown archive method" ;;
    esac
}

# Change Cursor.app icon
icon() {
    cp "$HOME/code/github.com/keaising/dotfile/logo/asprite.icns" \
       "/Applications/Cursor.app/Contents/Resources/Cursor.icns"
    sudo killall Finder Dock
}
