return {
    {
        "neovim/nvim-lspconfig",
        priority = 100,
        config = function()
            -- 1. set lsp
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            lspconfig.lua_ls.setup({
                on_attach = function(client)
                    client.server_capabilities.document_formatting = false
                    client.server_capabilities.document_range_formatting = false
                end,
                capabilities = capabilities,
                settings = {
                    Lua = {
                        format = {
                            enable = false,
                        },
                    },
                },
            })
            lspconfig.gopls.setup({
                capabilities = capabilities,
                filetypes = { "go", "gomod" },
                settings = {
                    gopls = {
                        env = {
                            GOFLAGS = "-tags=stage",
                        },
                        usePlaceholders = true,
                    },
                },
            })
            lspconfig.bashls.setup({
                capabilities = capabilities,
                filetypes = { "sh", "zsh" },
            })
            lspconfig.jsonls.setup({})
            lspconfig.pyright.setup({
                capabilities = capabilities,
            })
            lspconfig.terraformls.setup({})

            -- 3. change signs
            --
            -- local signs = {
            --     { name = "DiagnosticSignError", text = "" },
            --     { name = "DiagnosticSignWarn",  text = "" },
            --     { name = "DiagnosticSignHint",  text = "" },
            --     { name = "DiagnosticSignInfo",  text = "" },
            -- }
            local signs = {
                { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn", text = "" },
                { name = "DiagnosticSignHint", text = "" },
                { name = "DiagnosticSignInfo", text = "" },
            }

            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
            end

            vim.diagnostic.config({
                -- set to 'false' to disable diagnostic info in virtual text
                virtual_text = true,
                -- show signs
                signs = {
                    active = signs,
                },
                update_in_insert = true,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "none", -- none/single/double/rounded/solid/shadow
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            function LspFormatter()
                vim.lsp.buf.format({
                    filter = function(client)
                        return client.name ~= "lua_ls"
                    end,
                    async = true,
                })
            end
            vim.cmd([[ autocmd BufWritePre * lua LspFormatter() ]])
            vim.cmd([[ nnoremap <leader>fm :lua LspFormatter()<CR> ]])

            -- 4. add autocmd
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    local opts = { buffer = ev.buf }
                    -- other function in Telescope
                    vim.keymap.set("n", "<m-b>", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "<m-k>", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<m-j>", function()
                        vim.diagnostic.goto_next({
                            severity = vim.diagnostic.severity.ERROR,
                        })
                    end, opts)
                end,
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
