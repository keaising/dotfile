return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        config = function()
            require("nvim-treesitter.configs").setup({
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        node_incremental = "v",
                        node_decremental = "V",
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        -- Automatically jump forward to textobj, similar to targets.vim
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ic"] = "@call_expression",
                            ["ie"] = "@expression_list",
                            ["ik"] = "@keyed_element",
                        },
                    },
                },
                -- ensure_installed = "all", -- one of "all" or a list of languages
                ensure_installed = {
                    "go",
                    "gomod",
                    "python",
                    "lua",
                    "typescript",
                    "javascript",
                    "tsx",
                    "yaml",
                    "bash",
                    "json",
                    "toml",
                    "markdown",
                    "query",
                    "comment", -- highlight for "TODO", "FIXME"
                },
                ignore_install = {}, -- List of parsers to ignore installing
                highlight = {
                    enable = true,
                    disable = { "sql" }, -- list of language that will be disabled
                },
            })
        end,
    },
}
