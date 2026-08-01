# ============================================================
# Custom Functions
# ============================================================

# Measure zsh start time
# Uses $EPOCHREALTIME rather than /usr/bin/time: the BSD and GNU builds print
# incompatible formats, and the BSD one put the number where awk read a word.
timezsh() {
    zmodload zsh/datetime
    local -i runs=5
    local start total=0 i
    for (( i = 1; i <= runs; i++ )); do
        start=$EPOCHREALTIME
        zsh -i -c exit
        total=$(( total + EPOCHREALTIME - start ))
    done
    printf "average of %d runs: %.3fs\n" $runs $(( total / runs ))
}

# Enhanced cd with fzf and z.lua fallback
cd() {
    if [[ $# -eq 0 ]]; then
        if command -v fzf &>/dev/null; then
            local dir
            dir=$({
                # z.lua history
                if typeset -f _zlua &>/dev/null; then
                    _zlua -l 2>/dev/null | awk '{print $2}'
                fi
                # Pinned dirs and scan roots are declared by a private config,
                # since the useful ones are not shareable.
                (( ${#ZSH_CD_PINNED} )) && print -l -- $ZSH_CD_PINNED
                if command -v fd &>/dev/null; then
                    local root
                    for root in $ZSH_CD_SCAN_ROOTS; do
                        [[ -d $root ]] && fd --type d --max-depth 2 . "$root"
                    done
                    # ~/code
                    fd --type d --hidden --max-depth 4 --follow . "$HOME/code"
                fi
            } | sed 's|/$||' | awk '!seen[$0]++' | fzf --height 40% --reverse)
            [[ -d "$dir" ]] && builtin cd "$dir"
        else
            builtin cd
        fi
    else
        # Silenced: a miss is the normal path into z.lua. Re-run to surface the
        # real error only when there is no z.lua to fall back to.
        if ! builtin cd "$@" 2>/dev/null; then
            if typeset -f _zlua &>/dev/null; then
                _zlua "$@"
            else
                builtin cd "$@"
            fi
        fi
    fi
}

# Clone and cd into directory
glone() {
    [[ $# -ne 1 ]] && return 1
    local out
    out=$(mktemp) || return 1
    clone "$1" | tee "$out"
    local dir=$(head -n 1 "$out" | awk '{print $4}')
    rm -f "$out"
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

# Give Linux an `open`; on macOS the builtin /usr/bin/open is left alone.
if [[ "$OSTYPE" == linux* ]]; then
    open() {
        if [[ -n "$WSL_DISTRO_NAME" ]]; then
            wslview "$@"
        elif uname -r | grep -iq arch; then
            xdg-open "$@" &>/dev/null 2>&1
        else
            xdg-open "$@" 2>/dev/null
        fi
    }
fi

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

# Parsed line by line rather than sourced: `source .env` executes any $(...) in
# it, so entering an untrusted repo and running envup would run its code.
envup() {
    [[ -f .env ]] || return 0
    local key val count=0
    while IFS='=' read -r key val; do
        # One match does trimming, `export` stripping and identifier validation,
        # so comments and blank lines fall out as non-matches. Key lands in $match[2].
        [[ $key =~ '^[[:space:]]*(export[[:space:]]+)?([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*$' ]] || continue
        val=${val#[\"\']}
        val=${val%[\"\']}
        export "$match[2]=$val"
        (( count++ ))
    done < .env
    echo "exported $count env"
}

envdown() {
    [[ -f .env ]] || return 0
    local key count=0
    while IFS='=' read -r key _; do
        [[ $key =~ '^[[:space:]]*(export[[:space:]]+)?([A-Za-z_][A-Za-z0-9_]*)[[:space:]]*$' ]] || continue
        unset "$match[2]" 2>/dev/null && (( count++ ))
    done < .env
    echo "unset $count env"
}


z() {
  if [ $# -eq 0 ]; then
    local dir
    dir=$(_zlua -l 2>&1 | fzf --height 40% --reverse --nth 2.. --tac +s | sed 's/^[0-9,.]* *//')
    if [ -n "$dir" ]; then
      cd "$dir"
    fi
  else
    # With arguments: use normal mode
    _zlua "$@"
  fi
}
