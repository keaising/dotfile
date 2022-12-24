alias j='journal'
alias s='sudo systemctl'
alias i='sudo apt install'
if hash apt 2>/dev/null; then
	alias i='sudo apt install'
elif hash pacman 2>/dev/null; then
	alias i='sudo pacman -S'
fi

# # color
# zstyle :prompt:pure:path color 214
# zstyle :prompt:pure:prompt:error color 160
# zstyle :prompt:pure:prompt:success color 031
