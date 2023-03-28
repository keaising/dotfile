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
        end,
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
            -- vim.opt.list = true
            vim.opt.listchars:append("space:⋅")
            vim.opt.listchars:append("eol:↴")
            vim.g.indent_blankline_filetype = { "yml", "yaml", "json", "lua" }
            require("indent_blankline").setup({
                show_end_of_line = true,
                space_char_blankline = " ",
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
}
