return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        priority = 1000,
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        keys = {
            { "<C-n>", "<cmd>Neotree toggle<CR>", mode = "n", silent = true },
            { "<C-b>", "<cmd>Neotree buffers<CR>", mode = "n", silent = true },
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                window = {
                    mappings = {
                        ["<space>"] = "none",
                        ["o"] = "open",
                        ["c"] = "close_node",
                        ["<A-a>"] = "add_directory",
                    },
                },
                filesystem = {
                    filtered_items = {
                        hide_dotfiles = false,
                        hide_by_name = {
                            "node_modules",
                        },
                        never_show = {
                            ".DS_Store",
                            "thumbs.db",
                        },
                    },
                    window = {
                        mappings = {
                            ["o"] = "open",
                            ["<c-p>"] = "prev_git_modified",
                            ["<c-n>"] = "next_git_modified",
                        },
                    },
                    follow_current_file = {
                        enabled = true,
                    },
                },
            })
        end,
    },
    {
        "hedyhli/outline.nvim",
        lazy = true,
        cmd = { "Outline", "OutlineOpen" },
        keys = {
            { "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
        },
        config = function()
            require("outline").setup({
                outline_window = {
                    auto_jump = true,
                },
                keymaps = {
                    fold = "c", -- close
                    unfold = "o", -- open
                },
                outline_items = {
                    show_symbol_lineno = true,
                },
                symbols = {
                    icon_fetcher = function()
                        return ""
                    end,
                },
            })
        end,
    },
}
