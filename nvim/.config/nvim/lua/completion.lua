local M = {}

function M.init(packer)
	packer("hrsh7th/cmp-nvim-lsp")
	packer("hrsh7th/cmp-buffer")
	packer("hrsh7th/cmp-path")
	packer("hrsh7th/cmp-cmdline")
	packer("hrsh7th/cmp-emoji")

	packer({
		"hrsh7th/nvim-cmp",

		config = function()
			vim.cmd("set completeopt=menu,menuone,noselect")

			-- Setup nvim-cmp.
			local cmp = require("cmp")

			cmp.setup({
				snippet = {
					-- REQUIRED - you must specify a snippet engine
					expand = function(args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
						-- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},
				mapping = {
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-j>"] = cmp.mapping.select_next_item(),
					["<C-k>"] = cmp.mapping.select_prev_item(),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.close(),
					-- ["<CR>"] = cmp.mapping.confirm({
					--     select = true,
					-- }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					["<CR>"] = function(fallback)
						if cmp.visible() then
							cmp.confirm()
						else
							-- cmp.mapping.select_next_item()
							-- cmp.confirm()
							fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
						end
					end,
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm()
							-- elseif vim.fn["vsnip#available"](1) == 1 then
							-- feedkey("<Plug>(vsnip-expand-or-jump)", "")
							-- elseif has_words_before() then
							-- cmp.complete()
						else
							-- cmp.mapping.select_next_item()
							-- cmp.confirm()
							fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function()
						if cmp.visible() then
							cmp.select_prev_item()
							-- elseif vim.fn["vsnip#jumpable"](-1) == 1 then
							-- feedkey("<Plug>(vsnip-jump-prev)", "")
						end
					end, { "i", "s" }),
				},
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{
						name = "dictionary",
						keyword_length = 2,
					},
					{ name = "emoji" },
					-- { name = 'vsnip' }, -- For vsnip users.
					-- { name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.
				}, {
					{ name = "buffer" },
				}),
			})

			-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline("/", {
				sources = {
					{ name = "buffer" },
				},
			})

			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				sources = cmp.config.sources({
					{ name = "path" },
				}, {
					{ name = "cmdline" },
				}),
			})
		end,
	})

	packer({
		"uga-rosa/cmp-dictionary",
		config = function()
			require("cmp_dictionary").setup({
				dic = {
					["*"] = { "/usr/share/dict/words" },
					-- ["lua"] = "path/to/lua.dic",
					-- ["javascript,typescript"] = { "path/to/js.dic", "path/to/js2.dic" },
				},
				-- The following are default values, so you don't need to write them if you don't want to change them
				exact = 2,
				first_case_insensitive = false,
				document = false,
				document_command = "wn %s -over",
				async = false,
				capacity = 5,
				debug = false,
			})
		end,
	})
end

function M.capabilities()
	return require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
end

return M
