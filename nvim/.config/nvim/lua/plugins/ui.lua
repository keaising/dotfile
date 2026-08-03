return {
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
                threshold = 11,
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
            local colors = { "#E06C75", "#E5C07B", "#98C379", "#56B6C2", "#61AFEF", "#C678DD" }
            local highlights = {}
            local function define_ibl_highlights()
                for i, color in ipairs(colors) do
                    vim.api.nvim_set_hl(0, "IblIndent" .. i, { fg = color, nocombine = true })
                end
            end
            define_ibl_highlights()
            vim.api.nvim_create_autocmd("ColorScheme", { callback = define_ibl_highlights })
            for i = 1, #colors do
                highlights[i] = "IblIndent" .. i
            end
            require("ibl").setup({
                indent = {
                    char = "▏",
                    highlight = highlights,
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
        "utilyre/sentiment.nvim",
        event = "VeryLazy",
        version = "*",
        opts = {},
    },
}
