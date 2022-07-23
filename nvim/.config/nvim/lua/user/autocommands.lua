vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave "}, {
	callback = function ()
		vim.cmd [[ :echo "leave insert" ]]
	end
})
