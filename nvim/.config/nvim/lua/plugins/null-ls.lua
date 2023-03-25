return {
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local null_ls = require("null-ls")
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
		end
	},
}
