---@diagnostic disable: duplicate-set-field

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
    k("n", "gh", "<cmd>lua require('pretty_hover').hover()<CR>", bufopts)
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

return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            local servers = {
                "biome",
                "gopls",
                "pyright",
                "ruff",
                "tsgo",
                "vtsls",
            }

            local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
            -- Load from ~/.config/nvim/lsp/*.lua
            for _, server in ipairs(servers) do
                local config_file = lsp_dir .. "/" .. server .. ".lua"
                if vim.fn.filereadable(config_file) == 1 then
                    local ok, config = pcall(dofile, config_file)
                    if ok and config then
                        vim.lsp.config(server, config)
                    end
                end
            end

            -- Enable all LSP servers
            vim.lsp.enable(servers)
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
        "Fildo7525/pretty_hover",
        event = "LspAttach",
        opts = {},
    },
    {
        "ray-x/lsp_signature.nvim",
        event = "InsertEnter",
        opts = {
            max_width = function()
                return math.floor(vim.api.nvim_win_get_width(0) * 0.6)
            end,
            hint_enable = false,
        },
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
        opts = {
            progress = {
                ignore = { "null-ls" },
            },
        },
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
                    "vtsls",
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
