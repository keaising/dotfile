local biome = {
    "biome",
    "biome-check",
    -- "biome-organize-imports",
}
return {
    {
        -- := vim.bo.filetype
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            local lint = require("lint")
            lint.linters_by_ft = {
                fish = { "fish" },
                lua = { "selene" },
                python = { "ruff" },
                go = { "gofmt", "golines", "goimports" },
                yaml = { "yamllint" },
            }
        end,
    },
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                "<leader>gm",
                function()
                    require("conform").format({ async = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        ---@module "conform"
        ---@type conform.setupOpts
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                bash = { "shfmt" },
                python = { "isort", "ruff_organize_imports", "ruff_format" },
                go = { "gosimports", "gofmt", "golines" },
                -- sql = { "pg_format" },
                fish = { "fish_indent" },
                css = biome,
                javascript = biome,
                javascriptreact = biome,
                json = biome,
                markdown = { "prettierd", "prettier", stop_after_first = true },
                typescript = biome,
                typescriptreact = biome,
            },
            default_format_opts = {
                lsp_format = "fallback",
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_fallback = true,
            },
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "2" },
                },
                pg_format = {
                    prepend_args = { "--keyword-case", "2", "--wrap-limit", "80" },
                },
            },
        },
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },
}
