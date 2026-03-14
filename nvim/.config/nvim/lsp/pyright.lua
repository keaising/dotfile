-- For what diagnostic is enabled in which type checking mode, check doc:
-- https://github.com/microsoft/pyright/blob/main/docs/configuration.md#diagnostic-settings-defaults

-- Currently, the pyright also has some issues displaying hover documentation:
-- https://www.reddit.com/r/neovim/comments/1gdv1rc/what_is_causeing_the_lsp_hover_docs_to_looks_like/

local new_capability = {
    -- this will remove some of the diagnostics that duplicates those from ruff, idea taken and adapted from
    -- here: https://github.com/astral-sh/ruff-lsp/issues/384#issuecomment-1989619482
    textDocument = {
        publishDiagnostics = {
            tagSupport = {
                valueSet = { 2 },
            },
        },

        hover = {
            contentFormat = { "plaintext" },
            dynamicRegistration = true,
        },
    },
}

return {
    -- npm install -g @delance/runtime
    cmd = { "delance-langserver", "--stdio" },
    settings = {
        pyright = {
            -- disable import sorting and use Ruff for this
            disableOrganizeImports = true,
            disableTaggedHints = false,
        },
        python = {

            analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                typeCheckingMode = "standard",
                useLibraryCodeForTypes = true,
                -- suppress diagnostics that duplicate ruff's lint rules
                diagnosticSeverityOverrides = {
                    deprecateTypingAliases = false,
                    reportUnusedImport = "none",
                    reportUnusedVariable = "none",
                    reportMissingModuleSource = "none",
                },
                -- inlay hint settings are provided by pylance?
                inlayHints = {
                    callArgumentNames = "partial",
                    functionReturnTypes = true,
                    pytestParameters = true,
                    variableTypes = true,
                },
            },
        },
    },

    capabilities = new_capability,
}
