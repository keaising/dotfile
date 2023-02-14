local lspconfig_ok, _ = pcall(require, "lspconfig")
if not lspconfig_ok then
	return
end

local lsp_servers = {
	"jsonls",
	"gopls",
	"bashls",
	"dockerls",
	"pyright",
	"tsserver",
	"vimls",
}

------  setup lsp for lspconfig ------
local lspconfig = require("lspconfig")
local lsphandler = require("user.lsp.handlers")

for _, server in pairs(lsp_servers) do
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

------ lsp installer ------
local mason_ok, mason = pcall(require, "mason")
if not mason_ok then
	return
end
mason.setup()

local mason_config_ok, mason_config = pcall(require, "mason-lspconfig")
if not mason_config_ok then
	return
end

local all_binaries = {}

for i = 1, #lsp_servers do
	all_binaries[#all_binaries + 1] = lsp_servers[i]
end

mason_config.setup({
	ensure_installed = all_binaries,
	automatic_installation = true,
})
