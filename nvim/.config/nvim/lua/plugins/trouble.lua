return {
	{
		"folke/trouble.nvim", -- show all errors in project
		config = function()
			vim.api.nvim_set_keymap("n", "<leader>xx", ":TroubleToggle<cr>", { silent = true, noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
				{ silent = true, noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
				{ silent = true, noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>", { silent = true, noremap = true })
			vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>", { silent = true, noremap = true })
			vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>", { silent = true, noremap = true })
		end
	}
}
