-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
    return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
    return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup {
    auto_reload_on_write = true,
    open_on_setup = true,
    open_on_tab = true,
    view = {
        width = 35,
        -- height = 30,
        side = "left",
        -- preserve_window_proportions = true,
        number = true,
        signcolumn = "yes",
        mappings = {
            custom_only = false,
            list = { -- user mappings go here
                {
                    key = "<CR>",
                    action = "tabnew",
                },
            },
        },
    },
    filters = {
        dotfiles = false,
    },
    renderer = {
        icons = {
            glyphs = {
                default = "",
                symlink = "",
                git = {
                    unstaged = "",
                    staged = "",
                    unmerged = "",
                    renamed = "➜",
                    deleted = "",
                    untracked = "",
                    ignored = "◌",
                },
                folder = {
                    default = "",
                    open = "",
                    empty = "",
                    empty_open = "",
                    symlink = "",
                },
            }
        }
    }
}

-- vim.cmd(
--     "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"
-- )

vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
