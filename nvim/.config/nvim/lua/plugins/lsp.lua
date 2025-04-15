-- cSpell:disable
local handlers = {}

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

local function on_attach(client, bufnr)
    local utils = require("telescope.utils")
    local entry_display = require("telescope.pickers.entry_display")
    local displayer = entry_display.create({
        separator = " ",
        items = {
            { width = 4 },
            { width = nil },
        },
    })
    local function make_entry(entry)
        return {
            value = entry.filename,
            filename = entry.filename,
            ordinal = utils.transform_path({}, entry.filename),
            lnum = entry.lnum,
            col = entry.col,
            display = function(item)
                return displayer({
                    { item.lnum, "Aqua" },
                    { utils.transform_path({}, item.filename), "" },
                })
            end,
        }
    end
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "<m-b>", function()
        require("telescope.builtin").lsp_definitions()
    end, bufopts)
    vim.keymap.set("n", "gh", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "gi", function()
        require("telescope.builtin").lsp_implementations({
            show_line = false,
            entry_maker = make_entry,
        })
    end, bufopts)
    -- vim.keymap.set("n", "<m-k>", vim.lsp.buf.rename, bufopts)
    vim.keymap.set("n", "<m-k>", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true, noremap = true, silent = true, buffer = bufnr })
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
    vim.keymap.set("n", "`", vim.diagnostic.open_float, bufopts)
    vim.keymap.set("n", "gr", function()
        require("telescope.builtin").lsp_references({
            include_current_line = false,
            entry_maker = make_entry,
        })
    end, bufopts)
    vim.keymap.set("n", "<leader>ls", function()
        require("telescope.builtin").lsp_document_symbols()
    end, bufopts)
    vim.keymap.set("n", "<m-j>", function()
        vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
    end, bufopts)
end

return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            lspconfig.gopls.setup({
                handlers = handlers,
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                end,
                settings = {
                    filetypes = { "go", "gomod" },
                    gopls = {
                        env = {
                            GOFLAGS = "-tags=stage",
                        },
                        usePlaceholders = false, -- no placeholder fillfulment
                        vulncheck = "Imports",
                    },
                },
            })

            lspconfig.ruff.setup({
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                end,
                handlers = handlers,
            })
            lspconfig.pyright.setup({
                on_attach = on_attach,
                handlers = handlers,
                settings = {
                    pyright = {
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            ignore = { "*", "*/*" },
                        },
                    },
                },
            })
            lspconfig.lua_ls.setup({
                handlers = handlers,
                on_attach = function(client, bufnr)
                    -- client.server_capabilities.documentFormattingProvider = false
                    on_attach(client, bufnr)
                end,
                settings = {
                    Lua = {
                        workspace = {
                            library = {
                                vim.fn.expand("$VIMRUNTIME"),
                                vim.fn.expand("$VIMRUNTIME/lua"),
                                vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                            },
                        },
                    },
                },
            })
            lspconfig.ts_ls.setup({
                handlers = handlers,
                on_attach = on_attach,
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            })
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
                handlers = handlers,
                on_attach = on_attach,
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
        "rachartier/tiny-inline-diagnostic.nvim",
        event = "VeryLazy",
        priority = 1000,
        config = function()
            require("tiny-inline-diagnostic").setup({
                preset = "ghost",
                -- preset = "minimal",
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
                ensure_installed = {
                    "bashls",
                    "dockerls",
                    "jsonls",
                    "lua_ls",
                    "pyright",
                    "terraformls",
                    "ts_ls",
                    "typos_lsp",
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
                    "eslint_d",
                },
            })
        end,
    },
}
