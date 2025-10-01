return {
    {
        "saghen/blink.cmp",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "1.*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            keymap = {
                ["<C-e>"] = { "hide" },
                ["<C-b>"] = { "scroll_documentation_up" },
                ["<C-f>"] = { "scroll_documentation_down" },
                ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
                ["<Up>"] = { "select_prev", "fallback" },
                ["<Down>"] = { "select_next", "fallback" },
                ["<C-p>"] = { "select_prev", "fallback" },
                ["<C-n>"] = { "select_next", "fallback" },
                ["<Enter>"] = { "select_and_accept", "fallback" },
                ["<Tab>"] = {
                    function(cmp)
                        if cmp.snippet_active() then
                            return cmp.accept()
                        else
                            return cmp.select_and_accept()
                        end
                    end,
                    "snippet_forward",
                    "fallback",
                },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
            },
            completion = {
                documentation = { auto_show = true },
            },
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
                providers = {
                    path = {
                        opts = {
                            get_cwd = function(_)
                                return vim.fn.getcwd()
                            end,
                        },
                    },
                },
            },
            -- signature = { enabled = true },
            fuzzy = {
                sorts = {
                    "exact",
                    "score",
                    "sort_text",
                },
            },
            cmdline = {
                completion = {
                    menu = { auto_show = true },
                },
                keymap = {
                    ["<Enter>"] = {
                        function(cmp)
                            if cmp.snippet_active() then
                                return cmp.accept()
                            else
                                return cmp.select_accept_and_enter()
                            end
                        end,
                        "fallback",
                    },
                    ["<C-f>"] = { "accept" },
                },
            },
        },
        opts_extend = { "sources.default" },
    },
}
