return {
    {
        "nvim-telescope/telescope.nvim",
        -- dir = "/home/taiga/code/github.com/nvim-telescope/telescope.nvim",
        -- dev = true,
        event = "VeryLazy",
        dependencies = { "nvim-telescope/telescope-ui-select.nvim" },
        config = function()
            -- mappings
            local bufopts = { noremap = true, silent = true, buffer = true }
            local utils = require("telescope.utils")
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>s", function()
                builtin.find_files()
            end, bufopts)
            vim.keymap.set("n", "<C-s>", function()
                builtin.find_files()
            end, bufopts)
            vim.keymap.set("n", "<leader>ff", function()
                builtin.live_grep()
            end, bufopts)
            vim.keymap.set("n", "<C-f>", function()
                builtin.live_grep()
            end, bufopts)
            vim.keymap.set("n", "<leader>ld", function()
                builtin.diagnostics({
                    entry_maker = function(entry)
                        return {
                            value = entry.filename,
                            display = string.format(
                                "%4d:%-3d  %s   %s",
                                entry.lnum,
                                entry.col,
                                utils.transform_path({}, entry.filename),
                                entry.text
                            ),
                            filename = entry.filename,
                            ordinal = utils.transform_path({}, entry.filename),
                            lnum = entry.lnum,
                            col = entry.col,
                            type = entry.type,
                            text = entry.text,
                        }
                    end,
                })
            end, bufopts)
            vim.keymap.set("n", "gj", function()
                builtin.jumplist({ show_line = false })
            end, bufopts)
            vim.keymap.set("n", "gb", function()
                builtin.git_bcommits({})
            end, bufopts)
            -- vim.keymap.set("n", "lt", function()
            --     builtin.treesitter({})
            -- end, bufopts)

            -- settings
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
                            ["<C-y>"] = actions.preview_scrolling_up,
                            ["<C-e>"] = actions.preview_scrolling_down,
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
                        layout_config = normal_layout,
                        -- initial_mode = "normal",
                        sorting_strategy = "ascending",
                    },
                    jumplist = {
                        layout_config = wide_layout,
                        -- initial_mode = "normal",
                        sorting_strategy = "ascending",
                    },
                    diagnostics = {
                        layout_config = wide_layout,
                        -- initial_mode = "normal",
                        sorting_strategy = "ascending",
                    },
                    git_bcommits = {
                        layout_config = wide_layout,
                        -- initial_mode = "normal",
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
