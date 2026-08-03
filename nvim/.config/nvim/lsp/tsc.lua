---@type vim.lsp.Config
return {
    cmd = { "tsc", "--lsp", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    root_dir = function(bufnr, on_dir)
        -- Found tsconfig.json, now verify it's in a proper project root
        -- by checking for package manager files
        local root_markers = {
            "package-lock.json",
            "yarn.lock",
            "pnpm-lock.yaml",
            "bun.lockb",
            "bun.lock",
            "package.json",
            ".git",
        }
        local project_root = vim.fs.root(bufnr, root_markers)
        -- Use the project root if found, otherwise use tsconfig directory
        on_dir(project_root or tsconfig_root)
    end,
    flags = {
        debounce_text_changes = 150,
    },
}
