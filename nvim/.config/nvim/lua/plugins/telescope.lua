return {
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        keys = {
            { "<leader>s", "<cmd>Telescope find_files<CR>" },
            { "<C-s>", "<cmd>Telescope find_files<CR>" },
            { "<leader>ff", "<cmd>Telescope live_grep<CR>" },
            { "<C-f>", "<cmd>Telescope live_grep<CR>" },
            -- lsp
            { "gr", "<cmd>lua require'telescope.builtin'.lsp_references{}<CR>" },
            { "gi", "<cmd>lua require'telescope.builtin'.lsp_implementations{}<CR>" },
            { "gd", "<cmd>lua require'telescope.builtin'.diagnostics{}<CR>" },
            { "gj", "<cmd>lua require'telescope.builtin'.jumplist{}<CR>" },
            { "gt", "<cmd>lua require'telescope.builtin'.treesitter{}<CR>" },
        },
        config = function()
            local actions = require("telescope.actions")
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
                    layout_config = {
                        horizontal = {
                            preview_width = 0.6,
                        },
                    },
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
                        layout_config = {
                            width = 0.95,
                            horizontal = {
                                preview_width = 0.5,
                            },
                        },
                    },
                    jumplist = {
                        layout_config = {
                            width = 0.95,
                            horizontal = {
                                preview_width = 0.5,
                            },
                        },
                    },
                },
            })
        end,
    },
}
