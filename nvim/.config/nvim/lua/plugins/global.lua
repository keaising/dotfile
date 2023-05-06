return {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "RRethy/vim-illuminate",
    {
        "keaising/im-select.nvim",
        dir = "~/code/github.com/keaising/im-select.nvim",
        dev = false,
        config = function()
            require("im_select").setup({
                set_previous_events = {},
            })
        end,
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },
    {
        "smjonas/inc-rename.nvim",
        config = function()
            require("inc_rename").setup()
        end,
    },
}
