local status_ok, go = pcall(require, "go")
if not status_ok then
    return
end

go.setup({
	gofmt = 'gofmt',
	max_line_len = 88,
})

-- vim.cmd [[ 
-- autocmd BufWritePre *.go :silent! lua require('go.format').gofmt() 
-- autocmd BufWritePre (InsertLeave?) <buffer> lua vim.lsp.buf.formatting_sync(nil,500)
-- ]]

-- Run gofmt + goimport on save
vim.api.nvim_exec([[ autocmd BufWritePre *.go :silent! lua require('go.format').goimport() ]], false)

vim.api.nvim_set_keymap("n", "ggt", ":GoAddTest<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gj", ":GoAddTag json<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gjb", ":GoAddTag json,bson<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "gmt", ":GoModTidy<CR>", { noremap = true, silent = false })
