# ===================================================================
# check tools exist
# ===================================================================

if ! type fzf > /dev/null; then
	echo fzf not found! use 'install_fzf' to install.
fi

if ! type rg > /dev/null; then
	echo rg not found! use 'install_ripgrep' to install.
fi

if ! type fd > /dev/null; then
	echo fd not found! use 'install_fd' to install.
fi

if ! type bat > /dev/null; then
	echo bat not found! use 'install_bat' to install.
fi

if ! type gitui > /dev/null; then
	echo gitui not found! use 'install_gitui' to install.
fi

if ! type nvim > /dev/null; then
	echo nvim not found! use 'update_nvim' to install.
fi


export GITHUB_LOCATION="$HOME/code/github.com"
export LOCAL_BIN="$HOME/.local/bin/"


if [ -d "$HOME/.config/nvm" ]; then
	export NVM_DIR="$HOME/.config/nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# ===================================================================
# install tools exist
# ===================================================================
install_fzf () {
	setpx
	set -e
	set -o xtrace
	export FZF_REPO=$GITHUB_LOCATION/junegunn/fzf
	if [ ! -d "$FZF_REPO" ]; then
		git clone https://github.com/junegunn/fzf.git $FZF_REPO
	fi 
	cd $FZF_REPO
	git pull origin master
	$FZF_REPO/install
	cd -
	fzf --version
}

# 调整 mac 鼠标灵敏度
fix_mac_mouse () {
	defaults write -g com.apple.mouse.scaling 30
}

install_tpm () {
	setpx
	set -e
	set -o xtrace
	export TPM_REPO=$GITHUB_LOCATION/tmux-plugins/tpm
	if [ ! -d "$TPM_REPO" ]; then
		git clone https://github.com/tmux-plugins/tpm.git $TPM_REPO
	fi
}

update_nvim () {
	setpx
	set -e
	set -o xtrace
	wget https://github.com/neovim/neovim/releases/download/nightly/nvim-macos.tar.gz
	tar -zxf nvim-macos.tar.gz
	rm nvim-macos.tar.gz
	mkdir -p ~/.local/bin/nvim
	sudo rm -rf ~/.local/bin/nvim
	mv nvim-osx64 ~/.local/bin/nvim
	sudo rm -f /usr/local/bin/nvim
	ln -s ~/.local/bin/nvim/bin/nvim /usr/local/bin/nvim
	nvim --version
}

go_tools () {
	cd $HOME/code
	nopx
	export GOPROXY=https://goproxy.io 
	# gopls
	local _gogettools=(
		"golang.org/x/tools/gopls"
		"github.com/uudashr/gopkgs/cmd/gopkgs"
		"github.com/ramya-rao-a/go-outline"
		"github.com/haya14busa/goplay/cmd/goplay"
		"github.com/fatih/gomodifytags"
		"github.com/josharian/impl"
		"github.com/cweill/gotests/..."
		"github.com/golangci/golangci-lint/cmd/golangci-lint"
		"golang.org/x/tools/cmd/goimports"
		"github.com/rinchsan/gosimports/cmd/gosimports"
	)

	echo $PWD
	echo update go tools
	for _gogettool in $_gogettools; do
		echo update go install tools: $_gogettool
		GO111MODULE=on go install $_gogettool@latest
	done

	local -A _gotools=(
		"go-delve/delve" "go-delve/delve/cmd/dlv"
	)
	
	echo update go install tools
	for k v (${(kv)_gotools}) {
		echo update go install tools: $k
		local local_location=$GITHUB_LOCATION/$k
		local repo_url=https://github.com/$k
		if [ ! -d "$local_location" ]; then
			git clone $repo_url $local_location
		fi
		cd $local_location
		go install github.com/$v
	}
}
