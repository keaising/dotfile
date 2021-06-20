#!/bin/zsh


# path
_enabled_paths=(
	"/usr/bin"
	"/usr/local/bin"

	"$HOME/.local/bin" # normal install destination
	"$HOME/.cargo/bin" # cargo install destination

	"$HOME/code/gems/bin" # gems

	"$N_PREFIX/bin" #n

	"/usr/local/opt/openjdk/bin"   # macos
	"$HOME/Library/Python/3.9/bin" # ansible
)

for _enabled_path in $_enabled_paths[@]; do
	[[ -d "${_enabled_path}" ]] && \
	[[ ! :$PATH: == *":${_enabled_path}:"* ]] && \
	echo $_enabled_path
done
