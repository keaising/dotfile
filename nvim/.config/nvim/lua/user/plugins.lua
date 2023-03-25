
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
	-- use("smjonas/inc-rename.nvim") -- better rename, need nvim 0.8
	use("ray-x/lsp_signature.nvim")
	use({ "glepnir/lspsaga.nvim", branch = "main" })
	-- use("folke/trouble.nvim") -- show all errors in project

	-- go


end)
