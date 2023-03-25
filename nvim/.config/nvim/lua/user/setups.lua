-- For those plugins who just need a simple setup command

local plugin_list = {
	fidget = {
		sources = {
			["null-ls"] = {
				ignore = true
			},
		},
	},
	lsp_signature = {
		bind = true,
		handler_opts = {
			border = "none",
		},
	},
}
--lspsaga
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
