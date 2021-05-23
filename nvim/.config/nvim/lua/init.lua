require('FTerm').setup()
-- Keybinding
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Closer to the metal
map('n', '<C-i>', '<CMD>lua require("FTerm").toggle()<CR>', opts)
map('t', '<C-i>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)


require('nvim-treesitter.configs').setup({
	highlight = {
		enable           = true,
		use_languagetree = false
	},
	indent = {
		enable = true
	},
	incremental_selection = {
		enable  = true,
		keymaps = {
			init_selection    = "gnn",
			node_incremental  = "grn",
			scope_incremental = "grc",
			node_decremental  = "grm",
		},
	},
})


-- require'lspconfig'.gopls.setup{}


require("lsp-colors").setup({
		Error = "#db4b4b",
		Warning = "#e0af68",
		Information = "#0db9d7",
		Hint = "#10B981"
	})


require("trouble").setup {
	  -- your configuration comes here
	  -- or leave it empty to use the default settings
	  -- refer to the configuration section below
}


local cb = require('diffview.config').diffview_callback
require('diffview').setup {
  diff_binaries = false,    -- Show diffs for binaries
  file_panel = {
    width = 35,
    use_icons = true        -- Requires nvim-web-devicons
  },
  key_bindings = {
    -- The `view` bindings are active in the diff buffers, only when the current
    -- tabpage is a Diffview.
    view = {
      ["<tab>"]     = cb("select_next_entry"),  -- Open the diff for the next file 
      ["<s-tab>"]   = cb("select_prev_entry"),  -- Open the diff for the previous file
      ["j"]         = cb("next_entry"),         -- Bring the cursor to the next file entry
      ["k"]         = cb("next_entry"),         -- Bring the cursor to the previous file entry.
      ["<leader>e"] = cb("focus_files"),        -- Bring focus to the files panel
      ["<leader>b"] = cb("toggle_files"),       -- Toggle the files panel.

    },
    file_panel = {
      ["j"]         = cb("next_entry"),         -- Bring the cursor to the next file entry
      ["<down>"]    = cb("next_entry"),
      ["k"]         = cb("prev_entry"),         -- Bring the cursor to the previous file entry.
      ["<up>"]      = cb("prev_entry"),
      ["<cr>"]      = cb("select_entry"),       -- Open the diff for the selected entry.
      ["o"]         = cb("select_entry"),
      ["R"]         = cb("refresh_files"),      -- Update stats and entries in the file list.
      ["<tab>"]     = cb("select_next_entry"),
      ["<s-tab>"]   = cb("select_prev_entry"),
      ["<leader>e"] = cb("focus_files"),
      ["<leader>b"] = cb("toggle_files"),
    }
  }
}

------------------------------------------------------------------------------
-- lightbulb
------------------------------------------------------------------------------
-- require'nvim-lightbulb'.update_lightbulb {
-- 	sign = {
-- 		enabled = true,
-- 		-- Priority of the gutter sign
-- 		priority = 10,
-- 	},
-- 	float = {
-- 		enabled = true,
-- 		-- Text to show in the popup float
-- 		text = "wwwwwwwwwwwwwwwwwwww"
-- 		-- Available keys for window options:
-- 		-- - height     of floating window
-- 		-- - width      of floating window
-- 		-- - wrap_at    character to wrap at for computing height
-- 		-- - max_width  maximal width of floating window
-- 		-- - max_height maximal height of floating window
-- 		-- - pad_left   number of columns to pad contents at left
-- 		-- - pad_right  number of columns to pad contents at right
-- 		-- - pad_top    number of lines to pad contents at top
-- 		-- - pad_bottom number of lines to pad contents at bottom
-- 		-- - offset_x   x-axis offset of the floating window
-- 		-- - offset_y   y-axis offset of the floating window
-- 		-- - anchor     corner of float to place at the cursor (NW, NE, SW, SE)
-- 		-- - winblend   transparency of the window (0-100)
-- 		win_opts = {},
-- 	},
-- 	virtual_text = {
-- 		enabled = false,
-- 		-- Text to show at virtual text
-- 		text = "wwwwwwwwwwwwwwwwwwww"
-- 	}
-- }

------------------------------------------------------------------------------
-- gitsigns
------------------------------------------------------------------------------
-- require('gitsigns').setup {
--   signs = {
--     add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
--     change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
--     delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
--     topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
--     changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
--   },
--   numhl = false,
--   linehl = false,
--   current_line_blame = true,
--   sign_priority = 6,
--   update_debounce = 1,
--   status_formatter = nil, -- Use default
--   use_decoration_api = true,
--   use_internal_diff = true,  -- If luajit is presentcurrent_line_blame = true,
-- }


------------------------------------------------------------------------------
-- telescope
------------------------------------------------------------------------------
-- local actions = require("telescope.actions")
-- require('telescope').setup {
	-- defaults = {
		-- sorting_strategy = "ascending",
		-- layout_strategy  = "horizontal",
		-- layout_defaults  = {
			-- horizontal = {
				-- mirror = false,
			-- },
			-- vertical = {
				-- mirror = true,
			-- },
		-- },
		-- mappings = {
			-- i = {
				-- ["<CR>"]   = actions.select_tab,
				-- ["<C-o>"]  = actions.select_default + actions.center,
				-- ["<C-\\>"] = actions.select_vertical + actions.center,
				-- ["<C-l"]  = actions.select_horizontal + actions.center,
			-- },

			-- n = {
				-- ["<CR>"]   = actions.select_tab,
				-- ["<C-o>"]  = actions.select_default + actions.center,
				-- ["<C-\\>"] = actions.select_vertical + actions.center,
				-- ["<C-l"]  = actions.select_horizontal + actions.center,
			-- }
		-- }
	-- },
	-- extensions = {
		-- fzy_native = {
			-- override_generic_sorter = false,
			-- override_file_sorter    = true,
		-- }
	-- }
-- }

-- require('telescope').load_extension('fzy_native')


