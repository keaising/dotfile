alias j='sudo journalctl'
alias s='sudo systemctl'
alias i='sudo apt install'
if hash apt 2>/dev/null; then
	alias i='sudo apt install'
elif hash pacman 2>/dev/null; then
	alias i='sudo pacman -S'
fi

alias ts='tailscale'
