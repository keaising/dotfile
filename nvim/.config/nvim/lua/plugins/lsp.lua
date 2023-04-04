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

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set("n", "<m-b>", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
                    vim.keymap.set("n", "<m-k>", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, opts)
                    vim.keymap.set("n", "<space>ft", function()
                        vim.lsp.buf.format({ async = true })
                    end, opts)
                end,
            })
        end,
    },
    {
        "glepnir/lspsaga.nvim",
        event = "BufRead",
        -- Author always breaks things, so update when necessary
        commit = "db6cdf51bf5ae45e4aa65760e597cf0d587c66ee",
        pin = true,
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            --Please make sure you install markdown and markdown_inline parser
            { "nvim-treesitter/nvim-treesitter" },
        },
        config = function()
            local keymap = vim.keymap.set
            keymap("n", "gr", "<cmd>Lspsaga lsp_finder<CR>", { silent = true, noremap = true })
            keymap("n", "<A-d>", "<cmd>Lspsaga preview_definition<CR>", { silent = true })

            keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { silent = true })
            keymap("n", "K", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })

            -- keymap("n", "<m-k>", function()
            --     require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
            -- end)
            keymap("n", "<m-j>", function()
                require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
            end)

            require("lspsaga").setup({
                saga_winblend = 0,
                max_preview_lines = 20,
                finder_action_keys = {
                    open = { "<CR>", "o" },
                    vsplit = "v",
                    split = "s",
                    tabe = "t",
                    quit = { "<ESC>", "q" },
                    scroll_down = "<C-n>",
                    scroll_up = "<C-p>", -- quit can be a table
                },
                code_action_keys = {
                    quit = { "<ESC>", "q" },
                    exec = "<CR>",
                },
                rename_action_quit = "<ESC>",
                show_outline = {
                    win_position = "down",
                    -- set the special filetype in there which in left like nvimtree neotree defx
                    left_with = "",
                    win_width = 60,
                    auto_enter = true,
                    auto_preview = true,
                    virt_text = "┃",
                    jump_key = "o",
                    -- auto refresh when change buffer
                    auto_refresh = true,
                },
                symbol_in_winbar = {
                    enable = false,
                },
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
