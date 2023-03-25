return {
	{
		"neovim/nvim-lspconfig",
		priority = 100,
		config = function()
			local lspconfig = require('lspconfig')
			-- lspconfig.pyright.setup {}
			-- lspconfig.tsserver.setup {}
			-- lspconfig.rust_analyzer.setup {
			--     -- Server-specific settings. See `:help lspconfig-setup`
			--     settings = {
			--         ['rust-analyzer'] = {},
			--     },
			-- }
			lspconfig.lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
							path = vim.split(package.path, ';')
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			})
			lspconfig.gopls.setup {
				settings = {
					gopls = {
						env = {
							GOFLAGS = "-tags=stage",
						},
					},
				}
			}
			lspconfig.bashls.setup {
				filetypes = { "sh", "zsh" }
			}
			lspconfig.jsonls.setup {}
			lspconfig.lua_ls.setup {}
			lspconfig.pyright.setup {}
			lspconfig.terraformls.setup {}

			-- format on saving
			vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format()]]

			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', '<m-b>', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<m-k>', vim.lsp.buf.rename, opts)
					vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', '<space>ft', function()
						vim.lsp.buf.format { async = true }
					end, opts)
				end,
			})
		end
	},
	{
		"glepnir/lspsaga.nvim",
		-- event = "BufRead",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" }
		},
		config = function()
			local keymap = vim.keymap.set
			keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })
			keymap("n", "<A-d>", "<cmd>Lspsaga preview_definition<CR>", { silent = true })

			keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })
			keymap("n", "K", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

			-- keymap("n", "<m-k>", function()
			--     require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
			-- end)
			keymap("n", "<m-j>", function()
				require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
			end)

			require("lspsaga").setup({
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
		end,
	},
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({})
		end
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"williamboman/mason.nvim",
		},
		config = function()
			require("mason-lspconfig").setup {
				ensure_installed = {
					"bashls",
					"dockerls",
					"jsonls",
					"lua_ls",
					"pyright",
					"terraformls",
					"vimls",
					"yamlls",
				},
			}
			require('mason-tool-installer').setup({
				ensure_installed = {
					"black",
					"cspell",
					"jq",
					"shfmt",
					"stylua",
				}
			})
		end
	}
}
