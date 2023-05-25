return {
    "nvim-treesitter/nvim-treesitter",
    -- enabled = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-treesitter/playground",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            playground = {
                enable = true,
                disable = {},
                updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                persist_queries = false, -- Whether the query persists across vim sessions
                keybindings = {
                    toggle_query_editor = "o",
                    toggle_hl_groups = "i",
                    toggle_injected_languages = "t",
                    toggle_anonymous_nodes = "a",
                    toggle_language_display = "I",
                    focus_language = "f",
                    unfocus_language = "F",
                    update = "R",
                    goto_node = "<cr>",
                    show_help = "?",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = false,
                    keymaps = {
                        ["iv"] = "@key_value",
                    },
                },
            },
            -- ensure_installed = "all", -- one of "all" or a list of languages
            ensure_installed = {
                "go",
                "gomod",
                "query",
            },
            ignore_install = {}, -- List of parsers to ignore installing
            highlight = {
                enable = true, -- false will disable the whole extension
                disable = { "sql" }, -- list of language that will be disabled
            },
        })
    end,
}
