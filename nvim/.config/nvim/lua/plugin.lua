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
				auto_close = true,
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
			vim.cmd("hi LspSignatureActiveParameter guifg=NONE ctermfg=NONE guibg=#1d1f21 ctermbg=53 gui=Bold,underline,Italic cterm=Bold,underline,Italic guisp=#fbec9f")
		end,
	})

	packer({
		"f-person/git-blame.nvim",
		config = function()
			vim.g.gitblame_message_template = '       <author> <date> <summary>'
			vim.g.gitblame_date_format = '%Y-%m-%d %H:%M'
		end
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
			util.noremap("n", "<m-w>", ":bd<CR>")
			util.noremap("n", "<m-e>", ":BufferLinePick<CR>")
			require("bufferline").setup({
				options = {
					-- mode = 'tabs'
					numbers = "ordinal",
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
