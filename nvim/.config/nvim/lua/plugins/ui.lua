return {
    "famiu/bufdelete.nvim",
    {
        "akinsho/bufferline.nvim",
        config = function()
            require("bufferline").setup({
                options = {
                    numbers = "ordinal",
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    show_tab_indicators = false,
                },
            })
        end
    },
    {
        "nvim-lualine/lualine.nvim",
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
                            path = 1,                -- show relative path
                            symbols = {
                                modified = "[+]",    -- Text to show when the file is modified.
                                readonly = "[-]",    -- Text to show when the file is non-modifiable or readonly.
                                unnamed = "[Empty]", -- Text to sho for unnamed buffers.
                            },
                        },
                    },
                },
            })
        end
    },
    {
        "phaazon/hop.nvim",
        branch = "v2",
		config = function()
			require("hop").setup()
		end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function()
            require("indent_blankline").setup({
                space_char_blankline = " ",
                char_highlight_list = {
                    "IndentBlanklineIndent1",
                    "IndentBlanklineIndent2",
                    "IndentBlanklineIndent3",
                    "IndentBlanklineIndent4",
                    "IndentBlanklineIndent5",
                    "IndentBlanklineIndent6",
                },
            })
        end
    },
	{
		"kevinhwang91/nvim-ufo",
		dependencies = "kevinhwang91/promise-async",
		keys = {
			{ "zr", function() require("ufo").openAllFolds() end,  mode = "n", silent = true },
			{ "zm", function() require("ufo").closeAllFolds() end, mode = "n", silent = true },
		}
	},
    {
        "mrjones2014/smart-splits.nvim",
        keys = {
            { "<m-Left>",  function() require("smart-splits").resize_left() end,  mode = "n", silent = true },
            { "<m-Down>",  function() require("smart-splits").resize_down() end,  mode = "n", silent = true },
            { "<m-Up>",    function() require("smart-splits").resize_up() end,    mode = "n", silent = true },
            { "<m-Right>", function() require("smart-splits").resize_right() end, mode = "n", silent = true },
        }
    }
}
