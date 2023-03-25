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

vim.g.indent_blankline_filetype = { "yml", "yaml", "json" }
vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

for p, opt in pairs(plugin_list) do
	local status_ok, plugin = pcall(require, p)
	if not status_ok then
		goto continue
	end

	plugin.setup(opt)
	if p == "ufo" then

	end

	if p == "smart-splits" then

	end

	::continue::
end

--lspsaga
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
