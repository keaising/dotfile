-- cSpell:disable
return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "jose-elias-alvarez/null-ls.nvim",
        },
        config = function()
            vim.diagnostic.config({
                float = {
                    border = "rounded",
                },
            })
            local handlers = {
                ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
                ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
            }

            local on_attach = function(client, bufnr)
                -- Mappings.
                local bufopts = { noremap = true, silent = true, buffer = bufnr }
                -- { "<leader>ls", "<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>" },
                vim.keymap.set("n", "<m-b>", vim.lsp.buf.definition, bufopts)
                vim.keymap.set("n", "dh", vim.lsp.buf.hover, bufopts)
                vim.keymap.set("n", "gi", function()
                    require("telescope.builtin").lsp_implementations({})
                end, bufopts)
                vim.keymap.set("n", "<m-k>", vim.lsp.buf.rename, bufopts)
                vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
                vim.keymap.set("n", "gr", function()
                    require("telescope.builtin").lsp_references()
                end, bufopts)
                vim.keymap.set("n", "<leader>ls", function()
                    require("telescope.builtin").lsp_document_symbols()
                end, bufopts)

                -- format
                local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
                if client.server_capabilities.documentFormattingProvider then
                    vim.keymap.set("n", "<leader>fm", function()
                        vim.lsp.buf.format({ async = true })
                    end, bufopts)
                    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        group = group,
                        callback = function()
                            vim.lsp.buf.format({ bufnr = bufnr, async = false })
                        end,
                        desc = "[lsp] format on save",
                    })
                end
            end

            -- Set up lspconfig.
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            lspconfig.gopls.setup({
                handlers = handlers,
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                end,
                settings = {
                    filetypes = { "go", "gomod" },
                    gopls = {
                        env = {
                            GOFLAGS = "-tags=stage",
                        },
                        usePlaceholders = true,
                        hints = {
                            assignVariableTypes = true,
                            compositeLiteralFields = true,
                            compositeLiteralTypes = true,
                            constantValues = true,
                            functionTypeParameters = true,
                            parameterNames = true,
                            rangeVariableTypes = true,
                        },
                    },
                },
            })

            lspconfig.bashls.setup({
                handlers = handlers,
                capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "sh", "zsh" },
            })
            lspconfig.lua_ls.setup({
                handlers = handlers,
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    client.server_capabilities.documentFormattingProvider = false
                    on_attach(client, bufnr)
                end,
                settings = {
                    Lua = {
                        hint = {
                            enable = true,
                            setType = true,
                            arrayIndex = "Disable",
                        },
                        codelens = {
                            enable = true,
                        },
                        completion = {
                            postfix = ".",
                            showWord = "Disable",
                            workspaceWord = false,
                        },
                    },
                },
            })
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
                handlers = handlers,
                on_attach = on_attach,
            })
        end,
    },
    {
        "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup({})
        end,
    },
    {
        "j-hui/fidget.nvim",
        config = function()
            require("fidget").setup({
                sources = {
                    ["null-ls"] = {
                        ignore = true,
                    },
                },
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        event = "VeryLazy",
        dependencies = {
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            "williamboman/mason-lspconfig.nvim",
        },
        config = function()
            require("mason").setup({})
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "bashls",
                    "dockerls",
                    "jsonls",
                    "lua_ls",
                    "pyright",
                    "terraformls",
                    "vimls",
                    "yamlls",
                },
            })
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "black",
                    "cspell",
                    "jq",
                    "shfmt",
                    "stylua",
                },
            })
        end,
    },
}
