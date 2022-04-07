return function(packer)
	packer({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" } },
		config = function()
			local actions = require("telescope.actions")
			require("telescope").setup({
				defaults = {
					vimgrep_arguments = {
						"rg",
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--hidden",
						"--smart-case",
					},
					file_ignore_patterns = { ".git/", "node_modules" },
					default_mappings = false,
					mappings = {
						i = {
							["<esc>"] = actions.close,
							["<CR>"] = actions.select_tab,
							["<C-n>"] = actions.move_selection_previous,
							["<C-p>"] = actions.move_selection_next,
							["<C-o>"] = actions.select_default,
							-- maybe bug, don't take effect:
							-- ["<C-l>"] = actions.move_selection_next,
						},
					},
					-- layout_strategy = "cursor"
					-- sorting_strategy = 'ascending',
				},
				pickers = {
					find_files = {
						-- hidden = true,
						-- short_path = true,
						-- find_command = {'fd', '--hidden', "--type", "f", "--strip-cwd-prefix", '--exec-batch ls -l'}
						-- `sort` is not supported by fd, so replace fd with rg
						find_command = {
							"rg",
							"--sort=path",
							"--files",
							"--color=never",
							"--no-heading",
							"--with-filename",
							"--line-number",
							"--column",
							"--hidden",
							"--smart-case",
						},
					},
				},
			})

			local util = require("util")
			util.noremap("n", "<leader>ss", ":Telescope find_files<CR>")
			util.noremap("n", "<leader>ff", ":Telescope live_grep<CR>")
			util.noremap("n", "<leader>fb", ":Telescope buffers<CR>")
			util.noremap("n", "<leader>fh", ":Telescope help_tags<CR>")
		end,
	})

	packer({
		"kyazdani42/nvim-tree.lua",
		requires = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("nvim-tree").setup({
				auto_reload_on_write = true,
				open_on_setup = true,
				open_on_tab = true,
				view = {
					width = 35,
					-- height = 30,
					side = "left",
					-- preserve_window_proportions = true,
					number = true,
					signcolumn = "yes",
					mappings = {
						custom_only = false,
						list = { -- user mappings go here
							{
								key = "<CR>",
								action = "tabnew",
							},
						},
					},
				},
				filters = {
					custom = { ".git" },
				},
			})
			vim.cmd(
				"autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"
			)
		end,
	})

	packer({
		"preservim/nerdcommenter",
		config = function()
			vim.g.NERDDefaultAlign = "left"
			vim.g.NERDSpaceDelims = 1
			local util = require("util")
			util.noremap("n", "<m-/>", ":NERDCommenterToggle<CR>")
			util.noremap("v", "<m-/>", ":NERDCommenterToggle<CR>")
		end,
	})

	packer({
		"sainnhe/gruvbox-material",
		config = function()
			-- vim.cmd 'set termguicolors'
			vim.cmd("color gruvbox-material")
			vim.cmd(
				"hi LspSignatureActiveParameter guifg=NONE ctermfg=NONE guibg=#1d1f21 ctermbg=53 gui=Bold,underline,Italic cterm=Bold,underline,Italic guisp=#fbec9f"
			)
		end,
	})

	-- packer({
	--     "sainnhe/everforest",
	--     config = function()
	--         vim.cmd("set background=dark")
	--         vim.g.everforest_background='soft'
	--         vim.cmd("colorscheme everforest")
	--     end
	-- })

	packer({
		"f-person/git-blame.nvim",
		config = function()
			vim.g.gitblame_message_template = "       <author> <date> <summary>"
			vim.g.gitblame_date_format = "%Y-%m-%d %H:%M"
		end,
	})

	packer({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			require("trouble").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
				position = "bottom", -- position of the list can be: bottom, top, left, right
				height = 10, -- height of the trouble list when position is top or bottom
				width = 50, -- width of the list when position is left or right
				icons = true, -- use devicons for filenames
				mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
				fold_open = "", -- icon used for open folds
				fold_closed = "", -- icon used for closed folds
				group = true, -- group results by file
				padding = true, -- add an extra new line on top of the list
				action_keys = { -- key mappings for actions in the trouble list
					-- map to {} to remove a mapping, for example:
					-- close = {},
					close = "q", -- close the list
					cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
					refresh = "r", -- manually refresh
					jump = { "<cr>", "<tab>" }, -- jump to the diagnostic or open / close folds
					open_split = { "<c-x>" }, -- open buffer in new split
					open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
					open_tab = { "<c-t>" }, -- open buffer in new tab
					jump_close = { "o" }, -- jump to the diagnostic and close the list
					toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
					toggle_preview = "P", -- toggle auto_preview
					hover = "K", -- opens a small popup with the full multiline message
					preview = "p", -- preview the diagnostic location
					close_folds = { "zM", "zm" }, -- close all folds
					open_folds = { "zR", "zr" }, -- open all folds
					toggle_fold = { "zA", "za" }, -- toggle fold of current file
					previous = "k", -- preview item
					next = "j", -- next item
				},
				indent_lines = true, -- add an indent guide below the fold icons
				auto_open = false, -- automatically open the list when you have diagnostics
				auto_close = false, -- automatically close the list when you have no diagnostics
				auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
				auto_fold = false, -- automatically fold a file trouble list at creation
				auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
				signs = {
					-- icons / text used for a diagnostic
					error = "",
					warning = "",
					hint = "",
					information = "",
					other = "﫠",
				},
				use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
			})

			local util = require("util")
			util.noremap("n", "<leader>xx", "<cmd>TroubleToggle<cr>")
			util.noremap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>")
			util.noremap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>")
			util.noremap("n", "<leader>xl", "<cmd>Trouble loclist<cr>")
			util.noremap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>")
			util.noremap("n", "gR", "<cmd>Trouble lsp_references<cr>")
		end,
	})
	packer({
		"nvim-lualine/lualine.nvim",
		requires = {
			"kyazdani42/nvim-web-devicons",
			opt = true,
		},
		config = function()
			require("lualine").setup({
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
			})
		end,
	})

	packer({
		"akinsho/bufferline.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		config = function()
			vim.opt.termguicolors = true

			local util = require("util")
			util.noremap("n", "<m-{>", ":BufferLineCyclePrev<CR>")
			util.noremap("n", "<m-}>", ":BufferLineCycleNext<CR>")
			util.noremap("n", "<m-<>", ":BufferLineMovePrev<CR>")
			util.noremap("n", "<m->>", ":BufferLineMoveNext<CR>")
			util.noremap("n", "<m-w>", ":bd<CR>")
			util.noremap("n", "<m-e>", ":BufferLinePick<CR>")
			require("bufferline").setup({
				options = {
					-- mode = 'tabs'
					numbers = "ordinal",
					show_buffer_close_icons = false,
					show_close_icon = false,
					show_tab_indicators = false,
				},
			})
		end,
	})

	packer({
		"Raimondi/delimitMate",
		config = function()
			vim.g.delimitMate_expand_cr = 1
			vim.g.delimitMate_expand_space = 1
			vim.g.delimitMate_jump_expansion = 1
		end,
	})

	-- https://forge.chapril.org/swytch/dotfiles/src/branch/main/.config/nvim/lua/plugin/lsp_installer.lua
	-- packer({
	--     "williamboman/nvim-lsp-installer",
	--     cmd = {
	--         "LspInstall",
	--         "LspInstallInfo",
	--     },
	--     config = function()
	--         require("nvim-lsp-installer").setup()
	--     end,
	-- })
end
