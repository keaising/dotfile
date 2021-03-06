local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- vim.cmd [[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins.lua source <afile> | PackerSync
--   augroup end
-- ]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- helpers
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	use("kyazdani42/nvim-web-devicons")

	-- my plugins here
	use("keaising/im-select.nvim")
	-- use '~/code/github.com/keaising/im-select.nvim'

	-- UI
	use({
		"nvim-neo-tree/neo-tree.nvim",
		branch = "main",
		requires = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
	})
	use("akinsho/bufferline.nvim") -- buffer line management
	use("famiu/bufdelete.nvim") -- delete buffer without close window
	use("nvim-lualine/lualine.nvim") -- tab line management
	use("nvim-telescope/telescope.nvim") -- global search for files and symbols

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("hrsh7th/cmp-cmdline") -- cmdline completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")

	-- snippets
	use("SirVer/ultisnips") -- snippet engine
	use("quangnguyen30192/cmp-nvim-ultisnips") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/mason.nvim") -- install lsp/dap/linters
	use("williamboman/mason-lspconfig.nvim")

	-- LSP Application
	--use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' -- show lsp diagnostic info in a unique line
	use("j-hui/fidget.nvim") -- show progress of loading LSP servers
	use("RRethy/vim-illuminate") -- highlighting other uses of the word under the cursor
	use("smjonas/inc-rename.nvim") -- better rename
	use("ray-x/lsp_signature.nvim")
	use({ "glepnir/lspsaga.nvim", branch = "main" })
	use("folke/trouble.nvim") -- show all errors in project
	use("numToStr/Comment.nvim") -- comment selected line

	-- go
	use("ray-x/go.nvim")
	use("ray-x/guihua.lua")

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use("nvim-treesitter/nvim-treesitter-textobjects")
	use("windwp/nvim-autopairs")
	use("windwp/nvim-ts-autotag")

	-- git
	use("lewis6991/gitsigns.nvim")

	-- colorscheme
	use("sainnhe/gruvbox-material")
	-- use 'rebelot/kanagawa.nvim'
	use("sainnhe/sonokai")

	-- vim plugins
	use("voldikss/vim-floaterm")
	use("sbdchd/neoformat")
	use("junegunn/vim-easy-align")
	use("kshenoy/vim-signature") -- ?????????????????????????????? marks ???ma-mz ??????????????????
	use("tpope/vim-abolish") -- crs/crm/crc
	use("machakann/vim-sandwich")
	use("terryma/vim-expand-region")
	use("ruanyl/vim-gh-line")
	use("APZelos/blamer.nvim")
	-- use("tveskag/nvim-blame-line")
	use("simeji/winresizer")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
