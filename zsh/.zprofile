# Login shell only. Anything here runs once per login, not per interactive shell.

if [[ "$OSTYPE" == "darwin"* ]]; then
	# System-wide one-shot; running it per shell would just repeat the same ioctl.
	hidutil property --set '{"CapsLockDelayOverride":0}' &>/dev/null
fi

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
