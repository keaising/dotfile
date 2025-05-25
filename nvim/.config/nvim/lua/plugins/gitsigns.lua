return {
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                attach_to_untracked = true,
                -- this blame info will cover my code, annoying!
                current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
                    delay = 300,
                    ignore_whitespace = true,
                },
                current_line_blame_formatter = "         <author>, <author_time:> • <summary>",
                sign_priority = 0,
                status_formatter = nil, -- Use default
                max_file_length = 3000,
            })
        end,
    },
    {
        "ruifm/gitlinker.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("gitlinker").setup({
                opts = {
                    print_url = false,
                },
            })
            vim.api.nvim_set_keymap(
                "n",
                "<leader>gh",
                '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
                { silent = true }
            )
            vim.api.nvim_set_keymap(
                "v",
                "<leader>gh",
                '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
                {}
            )
        end,
    },
}
