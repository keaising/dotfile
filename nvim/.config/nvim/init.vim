source ~/.config/nvim/lua/user/keymaps.vim
source ~/.config/nvim/lua/user/options.vim
lua require "user.plugins"

" lua require "user.treesitter"
lua require "user.cmp"
lua require "user.lsp"
lua require "user.neotree"
lua require "user.null-ls"
lua require "user.lspsaga"

lua require "user.autopairs"
lua require "user.colorscheme"
lua require "user.telescope"

source ~/.config/nvim/lua/user/vim-plugins.vim

lua require "user.autocommands"
lua require "user.illuminate"
lua require "user.setups"
lua require "user.gitsigns"
