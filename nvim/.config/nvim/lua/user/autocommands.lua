vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

local function all_trim(s)
   return s:match( "^%s*(.-)%s*$" )
end

local im_cn = "im.rime.inputmethod.Squirrel.Rime"
local im_en = "com.apple.keylayout.ABC"

vim.api.nvim_create_autocmd({ "InsertEnter "}, {
	callback = function ()
		local current = all_trim(vim.fn.system{ 'im-select' })
		if current ~= vim.g["taiga_current_im_select"] then
			if vim.g["taiga_current_im_select"] == im_cn then
				vim.fn.system{ 'im-select', im_cn }
			end
		end
	end
})

vim.api.nvim_create_autocmd({ "InsertLeave "}, {
	callback = function ()
		local current = all_trim(vim.fn.system{ 'im-select' })
		vim.api.nvim_set_var('taiga_current_im_select', current)
		if current ~= im_en then
			vim.fn.system{ 'im-select', im_en }
		end
	end
})

