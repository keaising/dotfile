return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-telescope/telescope-ui-select.nvim" },
        keys = {
            { "<leader>s", "<cmd>Telescope find_files<CR>" },
            { "<C-s>", "<cmd>Telescope find_files<CR>" },
            { "<leader>ff", "<cmd>Telescope live_grep<CR>" },
            { "<C-f>", "<cmd>Telescope live_grep<CR>" },
            -- lsp
            -- common
            { "<leader>ld", "<cmd>lua require'telescope.builtin'.diagnostics{}<CR>" },
            { "gj", "<cmd>lua require'telescope.builtin'.jumplist{}<CR>" },
            { "gb", "<cmd>lua require'telescope.builtin'.git_bcommits{}<CR>" },
            { "<leader>lt", "<cmd>lua require'telescope.builtin'.treesitter{}<CR>" },
        },
        config = function()
            local actions = require("telescope.actions")
            local normal_layout = {
                horizontal = {
                    preview_width = 0.6,
                },
            }
            local wide_layout = {
                width = 0.95,
                horizontal = {
                    preview_width = 0.5,
                },
            }
            require("telescope").setup({
                defaults = {
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--hidden",
                        "--smart-case",
                    },
                    file_ignore_patterns = { ".git/", "node_modules" },
                    default_mappings = false,
                    mappings = {
                        i = {
                            ["<esc>"] = actions.close,
                            ["<CR>"] = actions.select_default,
                            ["<C-o>"] = actions.select_default,
                        },
                    },
                    layout_config = normal_layout,
                },
                pickers = {
                    find_files = {
                        find_command = {
                            "rg",
                            "--sort=path",
                            "--files",
                            "--color=never",
                            "--no-heading",
                            "--with-filename",
                            "--line-number",
                            "--column",
                            "--hidden",
                            "--smart-case",
                        },
                    },
                    lsp_references = {
                        layout_config = wide_layout,
                        initial_mode = "normal",
                        sorting_strategy = "ascending",
                    },
                    jumplist = {
                        layout_config = wide_layout,
                        initial_mode = "normal",
                        sorting_strategy = "ascending",
                    },
                    diagnostics = {
                        layout_config = wide_layout,
                        initial_mode = "normal",
                        sorting_strategy = "ascending",
                    },
                    git_bcommits = {
                        layout_config = wide_layout,
                        initial_mode = "normal",
                        sorting_strategy = "ascending",
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
