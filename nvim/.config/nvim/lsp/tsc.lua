-- pnpm only links bins into each package's node_modules, so walk up from the file, not just the root.
local function find_local_bin(start_dir, stop_dir, name)
    local dir = start_dir
    while dir do
        local candidate = dir .. "/node_modules/.bin/" .. name
        if vim.uv.fs_stat(candidate) then
            return candidate
        end
        if dir == stop_dir then
            return nil
        end
        local parent = vim.fs.dirname(dir)
        if parent == dir then
            return nil
        end
        dir = parent
    end
    return nil
end

-- tsgo first: tsrs beta still reports errors tsgo (the CI typecheck) accepts.
local function resolve_ts_server(root_dir)
    local start_dir = root_dir
    if root_dir then
        local file = vim.api.nvim_buf_get_name(0)
        if vim.startswith(file, root_dir) then
            start_dir = vim.fs.dirname(file)
        end
    end
    for _, name in ipairs({ "tsgo", "tsrs" }) do
        local local_bin = root_dir and find_local_bin(start_dir, root_dir, name)
        if local_bin then
            return local_bin
        end
        if vim.fn.executable(name) == 1 then
            return name
        end
    end
    return nil
end

---@type vim.lsp.Config
return {
    cmd = function(dispatchers, config)
        local exe = resolve_ts_server(config.root_dir)
        if not exe then
            vim.notify("tsc LSP: no tsrs or tsgo found", vim.log.levels.WARN)
            exe = "tsgo"
        end
        return vim.lsp.rpc.start({ exe, "--lsp", "--stdio" }, dispatchers, { cwd = config.root_dir })
    end,
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    root_dir = function(bufnr, on_dir)
        local root_markers = {
            "package-lock.json",
            "yarn.lock",
            "pnpm-lock.yaml",
            "bun.lockb",
            "bun.lock",
            "package.json",
            ".git",
        }
        on_dir(vim.fs.root(bufnr, root_markers))
    end,
    on_init = function(client)
        -- tsgo panics in codeLens/resolve (nil deref), then nvim pops NO_RESULT_CALLBACK_FOUND.
        client.server_capabilities.codeLensProvider = nil
    end,
    flags = {
        debounce_text_changes = 150,
    },
}
