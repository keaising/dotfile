-- cSpell:disable
local handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
}

local function on_attach(client, bufnr)
    -- mappings.
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

    -- format
    local function lsp_formatting(buf)
        vim.lsp.buf.format({
            filter = function(clt)
                return vim.tbl_contains({ "null-ls", "gopls", "lua_ls", "ruff_lsp" }, clt.name)
            end,
            bufnr = buf,
        })
    end
    local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set("n", "<leader>gn", function()
            lsp_formatting(bufnr)
        end, bufopts)
        vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
        vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            group = group,
            callback = function()
                lsp_formatting(bufnr)
            end,
            desc = "[lsp] format on save",
        })
    end
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

            lspconfig.ruff_lsp.setup({
                on_attach = function(client, bufnr)
                    on_attach(client, bufnr)
                end,
                handlers = handlers,
                init_options = {
                    settings = {
                        args = {},
                    },
                },
            })
            lspconfig.pyright.setup({
                on_attach = on_attach,
                handlers = handlers,
                settings = {
                    pyright = {
                        -- Using Ruff's import organizer
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            -- Ignore all files for analysis to exclusively use Ruff for linting
                            ignore = { "*", "*/*" },
                        },
                    },
                },
            })
            lspconfig.bashls.setup({
                handlers = handlers,
                -- capabilities = capabilities,
                on_attach = on_attach,
                filetypes = { "sh", "zsh" },
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

            local signs = {
                { name = "DiagnosticSignError", text = "" },
                { name = "DiagnosticSignWarn", text = "" },
                { name = "DiagnosticSignHint", text = "" },
                { name = "DiagnosticSignInfo", text = "" },
            }

            for _, sign in ipairs(signs) do
                vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
            end
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
                    diagnostic.severity = vim.diagnostic.severity["HINT"] -- ERROR, WARN, INFO, HINT
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
                    null_ls.builtins.diagnostics.fish,
                    null_ls.builtins.formatting.fish_indent,
                    cspell.diagnostics.with(cspell_config),
                    cspell.code_actions.with(cspell_config),
                    null_ls.builtins.formatting.stylua.with({
                        condition = function(utils)
                            return utils.root_has_file({ "stylua.toml", ".stylua.toml" })
                        end,
                    }),
                    -- null_ls.builtins.diagnostics.selene.with({
                    --     cwd = function(_)
                    --         -- https://github.com/Kampfkarren/selene/issues/339#issuecomment-1191992366
                    --         return vim.fs.dirname(
                    --             vim.fs.find({ "selene.toml" }, { upward = true, path = vim.api.nvim_buf_get_name(0) })[1]
                    --         ) or vim.fn.expand("~/.config/selene/") -- fallback value
                    --     end,
                    -- }),
                    null_ls.builtins.formatting.pg_format.with({
                        extra_args = { "--keyword-case", "2", "--wrap-limit", "80" },
                    }),
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = {
                            "css",
                            "javascript",
                            "javascriptreact",
                            "json",
                            "markdown",
                            "typescript",
                            "typescriptreact",
                            "yaml",
                        },
                    }),
                },
                handlers = handlers,
                on_attach = on_attach,
            })
        end,
    },
    -- {
    --     -- typescript/javascript
    --     "jose-elias-alvarez/typescript.nvim",
    --     enabled = true,
    --     config = function()
    --         -- local capabilities = require("cmp_nvim_lsp").default_capabilities()
    --         require("typescript").setup({
    --             disable_commands = true, -- prevent the plugin from creating Vim commands
    --             debug = false, -- enable debug logging for commands
    --             go_to_source_definition = {
    --                 fallback = true, -- fall back to standard LSP definition on failure
    --             },
    --             server = { -- pass options to lspconfig's setup method
    --                 handlers = handlers,
    --                 on_attach = function(client, bufnr)
    --                     on_attach(client, bufnr)
    --                 end,
    --             },
    --         })
    --     end,
    -- },
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
                    "ruff_lsp",
                    "terraformls",
                    "tsserver",
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
                },
            })
        end,
    },
}
