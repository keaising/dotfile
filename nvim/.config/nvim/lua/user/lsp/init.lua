local lspconfig_ok, _ = pcall(require, "lspconfig")
if not lspconfig_ok then
	return
end


local servers = {
	"jsonls",
	"sumneko_lua",
	"gopls",
	"bashls",
	"dockerls",
	"golangci_lint_ls",
	"pyright",
	-- "grammerly",
	"tsserver",
	"vimls",
}

-- lsp installer
local installer_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not installer_ok then
	return
end

lsp_installer.setup({
	ensure_installed = servers,
})


-- setup lsp for lspconfig
local lspconfig = require("lspconfig")
local lsphandler = require("user.lsp.handlers")

for _, server in pairs(servers) do
	local opts = {
		on_attach = lsphandler.on_attach,
		capabilities = lsphandler.capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end

lsphandler.setup()
