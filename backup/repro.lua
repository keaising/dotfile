-- DO NOT change the paths and don't remove the colorscheme
local root = vim.fn.fnamemodify("./.repro", ":p")

-- set stdpaths to use .repro
for _, name in ipairs({ "config", "data", "state", "cache" }) do
    vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

-- install plugins
vim.keymap.set("n", "<Leader>e", "<Plug>(x-file-explorer)", { silent = true })
local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local bufopts = { noremap = true, silent = true }
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "gb", function()
            builtin.git_bcommits({
                git_command = {
                    "git",
                    "log",
                    -- "--pretty=oneline",
                    -- "--abbrev-commit",
                    "--date=format:%y/%m/%d",
                    "--pretty=format:%C(auto) %h %ad %s",
                    "--follow",
                },
            })
        end, bufopts)
        vim.keymap.set("n", "gj", builtin.git_bcommits, bufopts)

        require("telescope").setup({})
    end,
}
local plugins = {
    M,
}
require("lazy").setup(plugins, {
    root = root .. "/plugins",
})
