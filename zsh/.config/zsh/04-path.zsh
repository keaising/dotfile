# Find command in priority order
typeset -U path  # Keep unique entries only

path=(
    # Go
    /usr/local/go/bin
    $HOME/code/go/bin
    $GOPATH/bin
    
    # Development tools
    $HOME/.local/share/nvim/mason/bin
    $HOME/code/gems/bin
    $HOME/.cargo/bin
    $HOME/.dotnet/tools
    
    # Node (n)
    $N_PREFIX/bin
    
    # Python
    $PYENV_ROOT/bin
    
    # JDK (macOS)
    /usr/local/opt/openjdk/bin
    /opt/homebrew/opt/openjdk/bin
    
    # CUDA (Linux)
    /usr/local/cuda/bin  # Ubuntu/Debian
    /opt/cuda/bin        # Arch
    
    # System
    $HOME/.local/bin
    /opt/homebrew/bin
    /opt/homebrew/sbin
    /usr/local/bin
    /usr/local/sbin
    /usr/local
    /usr/bin
    /usr/sbin
    
    # Keep existing PATH
    $path
)

