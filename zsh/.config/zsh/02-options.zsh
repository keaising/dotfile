# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=8000
setopt SHARE_HISTORY           # 共享历史
setopt HIST_IGNORE_ALL_DUPS    # 忽略重复
setopt HIST_FIND_NO_DUPS       # 搜索时不显示重复
setopt HIST_IGNORE_SPACE       # 忽略空格开头的命令
setopt HIST_REDUCE_BLANKS      # 删除多余空格
setopt INC_APPEND_HISTORY      # 实时追加历史

# Completion
autoload -Uz compinit
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
    compinit -i
else
    compinit -C -i
fi

# Completion config
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true

# zsh options
setopt AUTO_CD                 # 输入目录名自动 cd
setopt EXTENDED_GLOB           # 扩展通配符
setopt NO_CASE_GLOB            # 不区分大小写
setopt INTERACTIVE_COMMENTS    # 允许注释
