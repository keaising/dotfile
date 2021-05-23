
export STARSHIP_CONFIG=$HOME/.config/zsh/config.toml
# ==================================================================
# Install starship
# ==================================================================
if [ ! -f "`which starship`" ]; then
	echo "Installing starship ..."
	setpx
	sh -c "$(curl -fsSL https://starship.rs/install.sh)"
fi



eval "$(starship init zsh)"
