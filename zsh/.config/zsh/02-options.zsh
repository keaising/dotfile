# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
# HIST_IGNORE_DUPS, not HIST_IGNORE_ALL_DUPS: the latter rewrites older entries
# and loses history when several SHARE_HISTORY shells write concurrently.
setopt HIST_IGNORE_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# Completion
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
    compinit -i
else
    compinit -C -i
fi

# Completion config
zstyle ':completion:*' menu select
# `zstyle -e` defers evaluation, so LS_COLORS may be exported later in 03-env.zsh.
zstyle -e ':completion:*' list-colors 'reply=( ${(s.:.)LS_COLORS} )'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' rehash true
zstyle ':completion:*' use-cache on
# zsh will not create the parent dir, and a missing one fails the cache silently.
_zsh_compcache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d $_zsh_compcache ]] || mkdir -p $_zsh_compcache
zstyle ':completion:*' cache-path "$_zsh_compcache/compcache"
unset _zsh_compcache
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{yellow}%d%f'
zstyle ':completion:*:warnings' format '%F{red}no matches%f'

# zsh options
setopt AUTO_CD                 # 输入目录名自动 cd
setopt EXTENDED_GLOB           # 扩展通配符
setopt NO_CASE_GLOB            # 不区分大小写
setopt INTERACTIVE_COMMENTS    # 允许注释
setopt AUTO_PUSHD              # cd 压入目录栈，配合 cd -<Tab>
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT
unsetopt BEEP
