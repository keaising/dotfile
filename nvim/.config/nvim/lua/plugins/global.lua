return {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "RRethy/vim-illuminate",
    {
        "keaising/im-select.nvim",
        -- dir = "~/code/github.com/keaising/im-select.nvim",
        -- dev = true,
        config = function()
            require("im_select").setup({})
        end,
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup({})
        end,
    },
    {
        "Mr-LLLLL/vim-interestingwords",
        branch = "fix-next-item",
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({
                map_cr = true,
                check_ts = true,
                ts_config = {
                    lua = { "string", "source" },
                    javascript = { "string", "template_string" },
                    java = false,
                },
                disable_filetype = { "TelescopePrompt", "spectre_panel" },
                fast_wrap = {
                    map = "<M-e>",
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
                    offset = 0, -- Offset from pattern match
                    end_key = "$",
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    check_comma = true,
                    highlight = "PmenuSel",
                    highlight_grey = "LineNr",
                },
            })
        end,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {
            search = {
                multi_window = false,
                -- max_length = 2,
            },
            jump = {
                nohlsearch = true,
                autojump = true,
            },
            label = {
                uppercase = false,
                after = true,
                before = false,
                -- style = "overlay",
                current = true,
            },
            modes = {
                char = {
                    enabled = false, -- disable f/T/t/T
                },
            },
        },
        keys = {
            {
                "s",
                mode = { "n", "o", "x" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
            {
                ";",
                mode = { "n" },
                function()
                    require("flash").jump({ continue = true })
                end,
                desc = "Flash",
            },
        },
    },
}
