local function file_exists(filename)
	local f = io.open(filename, "r")
	if f == nil then
		return false
	end
	io.close(f)
	return true
end

local cspell_files = {
	"/home/taiga/.config/nvim/cspell.json",
	"/Users/taiga/.config/nvim/cspell.json",
}

return {
	{
		-- "jose-elias-alvarez/null-ls.nvim",
		"keaising/null-ls.nvim",
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
								for _, v in ipairs(cspell_files) do
									if file_exists(v) then
										return v
									end
								end
								return ""
							end,
							postprocess = function()
								os.execute(
									"cat ~/.config/nvim/cspell.json | jq -S '.words |= sort' | tee ~/.config/nvim/cspell.json > /dev/null")
							end
						},
					}),
				},
			})
		end,
	},
}
