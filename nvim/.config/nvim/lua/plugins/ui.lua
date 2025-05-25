return {
    "famiu/bufdelete.nvim",
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        config = function()
            require("bufferline").setup({
                options = {
                    numbers = "ordinal",
                    indicator = {
                        style = "underline",
                    },
                    show_buffer_close_icons = false,
                    show_close_icon = false,
                    show_tab_indicators = false,
                    show_buffer_icons = false,
                },
            })
        end,
    },
    {
        "axkirillov/hbac.nvim",
        config = function()
            require("hbac").setup({
                autoclose = true,
                threshold = 7,
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
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        config = function()
            vim.opt.list = true
            vim.opt.listchars:append("tab:| ")
            vim.opt.listchars:append("trail:.")
            vim.opt.listchars:append("extends:>")
            vim.opt.listchars:append("precedes:<")
            vim.opt.listchars:append("lead: ")
            vim.opt.listchars:append("space: ")
            require("ibl").setup({
                indent = {
                    char = "▏",
                },
                scope = {
                    show_start = false,
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
                icons = { empty = "", filled = "", lsp_prefix = "" },
                lsp = true,
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
