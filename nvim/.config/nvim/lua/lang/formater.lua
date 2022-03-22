return function(packer)
	packer({
		"sbdchd/neoformat",
		config = function()
			local util = require("util")
			util.noremap("n", "<leader>ft", ":Neoformat<CR>")
			util.noremap("v", "<leader>ft", ":Neoformat<CR>")

			vim.g.neoformat_lua_stylua = {
				exe = "stylua",
				args = { "--search-parent-directories", "--stdin-filepath", '"%:p"', "--", "-" },
				stdin = 1,
			}
			vim.g.neoformat_enabled_lua = { "stylua" }

			vim.g.neoformat_try_formatprg = 1
			vim.g.neoformat_only_msg_on_error = 1
		end,
	})
end
