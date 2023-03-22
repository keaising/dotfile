local ok, null_ls = pcall(require, "null-ls")
if not ok then
	return
end

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
					return "/home/taiga/.config/nvim/cspell.json"
				end,
			},
		}),
	},
})
