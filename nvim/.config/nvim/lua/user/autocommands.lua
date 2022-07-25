vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

vim.api.nvim_create_autocmd({ "InsertEnter "}, {
	callback = function ()
		local current = vim.fn.system{ 'im-select' }
		if vim.g["taiga_current_im_select"] ~= current then
			-- I have no idea why this don't work
			vim.fn.system{ 'im-select', vim.g["taiga_current_im_select"] }
		end
	end
})

vim.api.nvim_create_autocmd({ "InsertLeave "}, {
	callback = function ()
		local current = vim.fn.system{ 'im-select' }
		if current ~= "com.apple.keylayout.ABC" then
			vim.api.nvim_set_var('taiga_current_im_select', current)
			vim.fn.system{ 'im-select', 'com.apple.keylayout.ABC' }
		end
	end
})

