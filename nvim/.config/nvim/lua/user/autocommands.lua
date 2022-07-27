vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

local function all_trim(s)
   return s:match( "^%s*(.-)%s*$" )
end

local default_im_select = vim.g['im_select_default_im_select']
if default_im_select == nil or default_im_select == "" then
	default_im_select = "com.apple.keylayout.ABC"
end

vim.api.nvim_create_autocmd({ "InsertEnter "}, {
	callback = function ()
		local current_select = all_trim(vim.fn.system{ 'im-select' })
		local save = vim.g["im_select_current_im_select"]
		if current_select ~= save then
			vim.fn.system{ 'im-select', save }
		end
	end
})

vim.api.nvim_create_autocmd({ "InsertLeave "}, {
	callback = function ()
		local current_select = all_trim(vim.fn.system{ 'im-select' })
		vim.api.nvim_set_var('im_select_current_im_select', current_select)

		if current_select ~= default_im_select then
			vim.fn.system{ 'im-select', default_im_select }
		end
	end
})

