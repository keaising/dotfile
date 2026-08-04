return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").install({
                "go",
                "gomod",
                "python",
                "lua",
                "typescript",
                "javascript",
                "tsx",
                "yaml",
                "bash",
                "json",
                "toml",
                "markdown",
                "markdown_inline",
                "query",
                "comment",
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "*",
                callback = function()
                    if vim.bo.filetype ~= "sql" then
                        pcall(vim.treesitter.start)
                    end
                end,
            })
        end,
    },
}
