-- For those plugins who just need a simple setup command

local plugin_list = {
	fidget = {},
	inc_rename = {},
	im_select = {
		default_im_select = "com.apple.keylayout.ABC",
		disable_auto_restore = 0,
	},
	lsp_signature = {
		bind = true,
		hanler_opts = {
			border = "none",
		},
	},
	bufferline = {
		options = {
			numbers = "ordinal",
			show_buffer_close_icons = false,
			show_close_icon = false,
			show_tab_indicators = false,
		},
	},
	lualine = {
		options = {
			theme = "jellybeans",
			component_separators = {
				left = " ",
				right = " ",
			},
			section_separators = {
				left = " ",
				right = " ",
			},
		},
		sections = {
			lualine_c = {
				{
					"filename",
					path = 1, -- show relative path
					symbols = {
						modified = "[+]", -- Text to show when the file is modified.
						readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
						unnamed = "[No Name]", -- Text to show for unnamed buffers.
					},
				},
			},
		},
	},
	["treesitter-context"] = {
		mode = "topline",
	},
	hop = {},
	indent_blankline = {
		space_char_blankline = " ",
		char_highlight_list = {
			"IndentBlanklineIndent1",
			"IndentBlanklineIndent2",
			"IndentBlanklineIndent3",
			"IndentBlanklineIndent4",
			"IndentBlanklineIndent5",
			"IndentBlanklineIndent6",
		},
	},
}

vim.opt.list = true
vim.g.indent_blankline_filetype = {'yml', 'yaml', 'json'}
vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

for p, opt in pairs(plugin_list) do
	local status_ok, plugin = pcall(require, p)
	if status_ok then
		plugin.setup(opt)
	end
end
