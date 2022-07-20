local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    },
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use 'famiu/bufdelete.nvim'
    use 'akinsho/bufferline.nvim'
    use 'nvim-lualine/lualine.nvim'
    use 'nvim-telescope/telescope.nvim'

    -- cmp plugins
    use "hrsh7th/nvim-cmp" -- The completion plugin
    use "hrsh7th/cmp-buffer" -- buffer completions
    use "hrsh7th/cmp-path" -- path completions
    use "hrsh7th/cmp-cmdline" -- cmdline completions
    use "saadparwaiz1/cmp_luasnip" -- snippet completions
    use "hrsh7th/cmp-nvim-lsp"

    -- snippets
    use "L3MON4D3/LuaSnip" --snippet engine
    use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

    -- LSP
    use "neovim/nvim-lspconfig" -- enable LSP
    use "williamboman/nvim-lsp-installer" -- simple to use language server installer

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
    }
    use "windwp/nvim-autopairs"

    -- colorscheme
    use 'sainnhe/gruvbox-material'

    -- vim plugins
    use 'voldikss/vim-floaterm'
    use 'sbdchd/neoformat'
	use 'junegunn/vim-easy-align'
	use 'kshenoy/vim-signature' -- 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
	use 'tpope/vim-abolish'    -- crs/crm/crc
	use 'machakann/vim-sandwich'
	use 'terryma/vim-expand-region'
	use 'ruanyl/vim-gh-line'

	-- text object 
	use 'kana/vim-textobj-user' -- 基础插件：提供让用户方便的自定义文本对象的接口
	use 'kana/vim-textobj-syntax' -- 语法文本对象：iy/ay 基于语法的文本对象
	use 'kana/vim-textobj-function' -- { 'for':['c', 'cpp', 'vim', 'java', 'javascript', 'go', 'python', 'typescript'] } " 函数文本对象：if/af 支持 c/c++/vim/java
	use 'sgur/vim-textobj-parameter' -- 参数文本对象：i,/a, 包括参数或者列表元素
	use 'jceb/vim-textobj-uri' -- 提供 uri/url 的文本对象，iu/au 表示

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)
