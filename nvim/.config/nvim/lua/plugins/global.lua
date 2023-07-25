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
                set_previous_events = { "InsertEnter" },
                set_default_events = { "VimEnter", "InsertLeave", "CmdlineLeave" },
                keep_quiet_on_no_binary = true,
            })
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
}
