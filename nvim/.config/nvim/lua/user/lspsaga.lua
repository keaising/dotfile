local status_ok, saga = pcall(require, "lspsaga")
if not status_ok then
	return
end

saga.init_lsp_saga({
	saga_winblend = 0,
	max_preview_lines = 20,
	finder_action_keys = {
		open = { "<CR>", "o" },
		vsplit = "v",
		split = "s",
		tabe = "t",
		quit = { "<ESC>", "q" },
		scroll_down = "<C-n>",
		scroll_up = "<C-p>", -- quit can be a table
	},
	code_action_keys = {
		quit = { "<ESC>", "q" },
		exec = "<CR>",
	},
	rename_action_quit = "<ESC>",
	show_outline = {
		win_position = "down",
		-- set the special filetype in there which in left like nvimtree neotree defx
		left_with = "",
		win_width = 60,
		auto_enter = true,
		auto_preview = true,
		virt_text = "┃",
		jump_key = "o",
		-- auto refresh when change buffer
		auto_refresh = true,
	},
})

-- reference
vim.keymap.set("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })

-- code action
-- vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
-- vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", { silent = true })
vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })


-- show hover doc
-- vim.keymap.set("n", "<A-h>", require("lspsaga.hover").render_hover_doc, { silent = true })
vim.keymap.set("n", "<A-n>", "<cmd>Lspsaga preview_definition<CR>", { silent = true })

-- show signature help
-- vim.keymap.set("n", "gs", "<Cmd>Lspsaga signature_help<CR>", { silent = true, noremap = true })

-- rename
-- vim.keymap.set("n", "<A-k>", "<cmd>Lspsaga rename<CR>", { silent = true,noremap = true })

-- preview definition
-- vim.keymap.set("n", "gd", "<cmd>Lspsaga preview_definition<CR>", { silent = true })
