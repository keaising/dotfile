return {
	{
		-- "jose-elias-alvarez/null-ls.nvim",
		"keaising/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			---@diagnostic disable-next-line: unused-local, unused-function
			local lsp_filter = function(client)
				return client.name ~= "lua_ls"
			end

			-- 2. format on saving
			vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format{ filter = lsp_filter }]])

			local null_ls = require("null-ls")
			vim.cmd([[ nnoremap <silent> <Leader>fm :lua vim.lsp.buf.format { filter = lsp_filter }<CR> ]])
			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.cspell.with({
						extra_args = { "--config", "~/.config/nvim/cspell.json" },
						diagnostics_postprocess = function(diagnostic)
							diagnostic.severity = vim.diagnostic.severity["INFO"] -- ERROR, WARN, INFO, HINT
						end,
					}),
					null_ls.builtins.code_actions.cspell.with({
						config = {
							find_json = function(_)
								return vim.fn.expand("~/.config/nvim/cspell.json")
							end,
							postprocess = function()
								os.execute(
									"cat ~/.config/nvim/cspell.json | jq -S '.words |= sort' | tee ~/.config/nvim/cspell.json > /dev/null"
								)
							end,
						},
					}),
					-- null_ls.builtins.formatting.jq,
					null_ls.builtins.formatting.stylua.with({
						extra_args = { "--indent-type", "Spaces", "--indent-width", "4" },
					}),
					null_ls.builtins.formatting.pg_format.with({
						extra_args = { "--keyword-case", "2", "--wrap-limit", "80" },
					}),
					null_ls.builtins.formatting.prettier.with({
						filetypes = { "json", "yaml" },
					}),
					null_ls.builtins.formatting.shfmt.with({
						filetypes = { "sh", "zsh" },
					}),
					null_ls.builtins.formatting.black,
				},
			})
		end,
	},
}
