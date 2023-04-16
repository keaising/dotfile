return {
    "famiu/bufdelete.nvim",
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        config = function()
            require("bufferline").setup({
                options = {
                    numbers = "ordinal",
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    show_tab_indicators = false,
                    show_buffer_icons = false,
                },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("lualine").setup({
                options = {
                    -- theme = "jellybeans",
                    theme = "gruvbox",
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
                                unnamed = "[Empty]", -- Text to sho for unnamed buffers.
                            },
                        },
                    },
                },
            })
        end,
    },
    {
        "phaazon/hop.nvim",
        event = "VeryLazy",
        branch = "v2",
        config = function()
            require("hop").setup()
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        lazy = false,
        config = function()
            vim.opt.termguicolors = true
            vim.cmd([[highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine]])
            vim.cmd([[highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine]])
            vim.cmd([[highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine]])
            vim.cmd([[highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine]])
            vim.cmd([[highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine]])
            vim.cmd([[highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine]])

            vim.opt.list = true
            vim.opt.listchars:append("tab:| ")
            vim.opt.listchars:append("trail:.")
            vim.opt.listchars:append("extends:>")
            vim.opt.listchars:append("precedes:<")

            vim.g.indent_blankline_filetype = { "yml", "yaml", "json", "lua", "python" }

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
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        lazy = false,
        dependencies = "kevinhwang91/promise-async",
        config = function()
            vim.keymap.set("n", "zr", require("ufo").openAllFolds)
            vim.keymap.set("n", "zm", require("ufo").closeAllFolds)
            require("ufo").setup({})
        end,
    },
    {
        "mrjones2014/smart-splits.nvim",
        event = "VeryLazy",
        keys = {
            {
                "<m-Left>",
                function()
                    require("smart-splits").resize_left()
                end,
                mode = "n",
                silent = true,
            },
            {
                "<m-Down>",
                function()
                    require("smart-splits").resize_down()
                end,
                mode = "n",
                silent = true,
            },
            {
                "<m-Up>",
                function()
                    require("smart-splits").resize_up()
                end,
                mode = "n",
                silent = true,
            },
            {
                "<m-Right>",
                function()
                    require("smart-splits").resize_right()
                end,
                mode = "n",
                silent = true,
            },
        },
    },
    {
        "projekt0n/circles.nvim",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("circles").setup({
                icons = { empty = "", "", filled = "", lsp_prefix = "" },
            })
        end,
    },
    {
        "utilyre/sentiment.nvim",
        event = "VeryLazy",
        version = "*",
        opts = {},
    },
}
