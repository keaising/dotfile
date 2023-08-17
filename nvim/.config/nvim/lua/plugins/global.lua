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
            require("im_select").setup({
                set_previous_events = {},
                set_default_events = { "VimEnter", "InsertLeave", "CmdlineLeave" },
                keep_quiet_on_no_binary = true,
            })
        end,
    },
    {
        "keaising/textobj-backtick.nvim",
        -- dir = "~/code/github.com/keaising/textobj-backtick.nvim",
        -- dev = true,
        config = function()
            require("textobj-backtick").setup({})
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
            require("inc_rename").setup()
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
                map_cr = false,
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
}
