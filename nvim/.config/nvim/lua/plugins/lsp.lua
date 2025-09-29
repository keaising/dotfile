---@diagnostic disable: duplicate-set-field

local signature_help = vim.lsp.buf.signature_help
vim.lsp.buf.signature_help = function()
    return signature_help({
        border = vim.g.border_style,
        focusable = false,
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
    })
end

local hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function()
    return hover({
        border = vim.g.border_style,
        max_height = math.floor(vim.o.lines * 0.5),
        max_width = math.floor(vim.o.columns * 0.4),
    })
end

local function general_on_attach(_, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    local fzf = require("fzf-lua")
    local k = vim.keymap.set
    local go_to_definition = function()
        fzf.lsp_definitions({
            jump1 = true,
            ignore_current_line = true,
            multiline = 2,
        })
    end
    k("n", "<m-b>", go_to_definition, bufopts)
    k("n", "gd", go_to_definition, bufopts)
    k("n", "gh", vim.lsp.buf.hover, bufopts)
    k("n", "gi", function()
        fzf.lsp_implementations({
            jump1 = true,
            ignore_current_line = true,
            show_line = false,
            multiline = 2,
        })
    end, bufopts)
    k("n", "<m-k>", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true, noremap = true, silent = true, buffer = bufnr })
    k("n", "<m-.>", function()
        fzf.lsp_code_actions({ previewer = false })
    end, bufopts)
    k("n", "<leader>ca", function()
        fzf.lsp_code_actions({ previewer = false })
    end, bufopts)
    k("n", "K", "<cmd>lua require('pretty_hover').hover()<CR>", bufopts)
    k("n", "`", vim.diagnostic.open_float, bufopts)
    k("n", "gr", function()
        fzf.lsp_references({
            jump1 = true,
            ignore_current_line = true,
            include_current_line = false,
            multiline = 2,
        })
    end, bufopts)
    k("n", "<leader>ls", fzf.lsp_document_symbols, bufopts)
    k("n", "<m-j>", function()
        vim.diagnostic.jump({
            count = 1,
            float = true,
            severity = {
                vim.diagnostic.severity.ERROR,
                vim.diagnostic.severity.WARN,
            },
        })
    end, bufopts)
end

local function vtsls_on_attach(_, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    local fzf = require("fzf-lua")
    local k = vim.keymap.set
    -- local go_to_definition = function()
    --     fzf.lsp_definitions({
    --         jump1 = true,
    --         ignore_current_line = true,
    --         multiline = 2,
    --     })
    -- end
    -- k("n", "<m-b>", go_to_definition, bufopts)
    -- k("n", "gd", go_to_definition, bufopts)
    -- k("n", "gi", function()
    --     fzf.lsp_implementations({
    --         jump1 = true,
    --         ignore_current_line = true,
    --         show_line = false,
    --         multiline = 2,
    --     })
    -- end, bufopts)
    -- k("n", "<m-k>", function()
    --     return ":IncRename " .. vim.fn.expand("<cword>")
    -- end, { expr = true, noremap = true, silent = true, buffer = bufnr })
    k("n", "<m-.>", function()
        fzf.lsp_code_actions({ previewer = false })
    end, bufopts)
    k("n", "<leader>ca", function()
        fzf.lsp_code_actions({ previewer = false })
    end, bufopts)
    k("n", "gh", "<cmd>lua require('pretty_hover').hover()<CR>", bufopts)
    k("n", "K", "<cmd>lua require('pretty_hover').hover()<CR>", bufopts)
    -- k("n", "`", vim.diagnostic.open_float, bufopts)
    -- k("n", "gr", function()
    --     fzf.lsp_references({
    --         jump1 = true,
    --         ignore_current_line = true,
    --         include_current_line = false,
    --         multiline = 2,
    --     })
    -- end, bufopts)
    -- k("n", "<leader>ls", fzf.lsp_document_symbols, bufopts)
    -- k("n", "<m-j>", function()
    --     vim.diagnostic.jump({
    --         count = 1,
    --         float = true,
    --         severity = {
    --             vim.diagnostic.severity.ERROR,
    --             vim.diagnostic.severity.WARN,
    --         },
    --     })
    -- end, bufopts)
end

return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            vim.lsp.enable("gopls")
            -- python
            vim.lsp.enable("ruff")
            vim.lsp.enable("pyright")
            -- vim.lsp.enable("vtsls")
            vim.lsp.enable("tsgo")
            vim.lsp.enable("biome")
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        -- "keaising/null-ls.nvim",
        -- dir = "~/code/github.com/keaising/null-ls.nvim",
        -- dev = true,
        dependencies = "davidmh/cspell.nvim",
        config = function()
            local null_ls = require("null-ls")
            local cspell = require("cspell")
            local cspell_config = {
                diagnostics_postprocess = function(diagnostic)
                    diagnostic.severity = vim.diagnostic.severity["HINT"]
                end,
                config = {
                    find_json = function(_)
                        return vim.fn.expand("~/.config/nvim/cspell.json")
                    end,
                    on_success = function(cspell_config_file_path, params, action_name)
                        if action_name == "add_to_json" then
                            os.execute(
                                string.format(
                                    "cat %s | jq -S '.words |= sort' | tee %s > /dev/null",
                                    cspell_config_file_path,
                                    cspell_config_file_path
                                )
                            )
                        end
                    end,
                },
            }
            null_ls.setup({
                sources = {
                    cspell.diagnostics.with(cspell_config),
                    cspell.code_actions.with(cspell_config),
                },
                on_attach = general_on_attach,
            })
        end,
    },
    {
        "VidocqH/lsp-lens.nvim",
        config = function()
            require("lsp-lens").setup({
                sections = {
                    definition = false,
                    git_authors = false,
                },
            })
        end,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
            },
        },
    },
    {
        "pmizio/typescript-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        -- enabled = false,
        config = function()
            require("typescript-tools").setup({
                on_attach = function(client, bufnr)
                    if client.name == "typescript-tools" then
                        client.server_capabilities.completionProvider = nil
                        client.server_capabilities.referencesProvider = nil
                        client.server_capabilities.documentSymbolProvider = nil
                        client.handlers["textDocument/publishDiagnostics"] = function() end
                    end
                    vtsls_on_attach(_, bufnr)
                end,
                settings = {
                    expose_as_code_action = { "all" },
                    code_lens = "all",
                },
            })
        end,
    },
    {
        "Fildo7525/pretty_hover",
        event = "LspAttach",
        opts = {},
    },
    {
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require("tiny-inline-diagnostic").setup({
                preset = "ghost",
                signs = {
                    left = "",
                    right = "",
                    diag = "",
                    arrow = "",
                    vertical_end = "",
                },
                options = {
                    show_source = true,
                },
            })
            vim.diagnostic.config({
                virtual_text = false,
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "",
                        [vim.diagnostic.severity.INFO] = "",
                    },
                },
                update_in_insert = true,
                underline = true,
                severity_sort = true,
                float = {
                    focusable = false,
                    style = "minimal",
                    border = "single",
                    source = true,
                    header = "",
                    prefix = "",
                    suffix = "",
                },
            })
        end,
    },
    {
        "j-hui/fidget.nvim",
        branch = "legacy",
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
        config = function()
            require("mason").setup({})
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
            require("mason-lspconfig").setup({
                automatic_enable = true,
                ensure_installed = {
                    "bashls",
                    "dockerls",
                    "jsonls",
                    "lua_ls",
                    "pyright",
                    -- "basedpyright",
                    "terraformls",
                    -- "ts_ls",
                    -- "vtsls",
                    -- "typos_lsp",
                    "vimls",
                    "yamlls",
                },
            })
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = "williamboman/mason.nvim",
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    "black",
                    "cspell",
                    "jq",
                    "prettier",
                    "ruff",
                    "selene",
                    "shfmt",
                    "stylua",
                    "isort",
                    "yamllint",
                },
            })
        end,
    },
}
