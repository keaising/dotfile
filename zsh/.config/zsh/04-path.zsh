# Find command in priority order
typeset -U path  # Keep unique entries only

path=(
    # Go
    /usr/local/go/bin
    $GOPATH/bin

    # Development tools
    $HOME/.local/share/nvim/mason/bin
    $HOME/code/gems/bin
    $HOME/.dotnet/tools

    # Node (n)
    $N_PREFIX/bin

    # Bun
    $BUN_INSTALL/bin

    # Rust
    $HOME/.cargo/bin

    # CUDA (Linux)
    /usr/local/cuda/bin  # Ubuntu/Debian
    /opt/cuda/bin        # Arch

    # System
    $HOME/.local/bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /usr/sbin

    # Keep existing PATH
    $path
)

# Drop entries that do not exist, so command lookup stops stat-ing them.
# Cost: a dir created after startup needs a new shell to enter PATH.
path=( ${^path}(N-/) )

