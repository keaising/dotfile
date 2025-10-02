return {
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        -- "typescript",
        -- "typescriptreact",
        -- "typescript.tsx",
    },
    root_dir = function(bufnr, on_dir)
        -- The project root is where the LSP can be started from
        -- As stated in the documentation above, this LSP supports monorepos and simple projects.

        -- We select then from the project root, which is identified by the presence of a package
        -- manager lock file.
        local root_markers =
            { "package.json", "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
        -- Give the root markers equal priority by wrapping them in a table
        -- We fallback to the current working directory if no project root is found
        local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

        on_dir(project_root)
    end,
}
