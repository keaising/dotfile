return {
    {
        -- "jose-elias-alvarez/null-ls.nvim",
        "keaising/null-ls.nvim",
        branch = "add_hook_for_cspell",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.diagnostics.cspell.with({
                        extra_args = { "--config", "~/.config/nvim/cspell.json" },
                        diagnostics_postprocess = function(diagnostic)
                            diagnostic.severity = vim.diagnostic.severity["INFO"] -- ERROR, WARN, INFO, HINT
                        end,
                    }),
                    null_ls.builtins.code_actions.cspell.with({
                        config = {
                            find_json = function(_)
                                return vim.fn.expand("~/.config/nvim/cspell.json")
                            end,
                            on_success = function(_)
                                os.execute(
                                    "cat ~/.config/nvim/cspell.json | jq -S '.words |= sort' | tee ~/.config/nvim/cspell.json > /dev/null"
                                )
                            end,
                        },
                    }),
                    null_ls.builtins.formatting.jq,
                    null_ls.builtins.formatting.stylua.with({
                        extra_args = { "--indent-type", "Spaces", "--indent-width", "4" },
                    }),
                    null_ls.builtins.formatting.pg_format.with({
                        extra_args = { "--keyword-case", "2", "--wrap-limit", "80" },
                    }),
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = { "yaml" },
                    }),
                    null_ls.builtins.formatting.shfmt.with({
                        filetypes = { "sh", "zsh" },
                    }),
                    null_ls.builtins.formatting.black,
                },
            })
        end,
    },
}
