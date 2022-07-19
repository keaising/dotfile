local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
    return
end

local actions = require "telescope.actions"

telescope.setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--hidden",
            "--smart-case",
        },
        file_ignore_patterns = { ".git/", "node_modules" },
        default_mappings = false,
        mappings = {
            i = {
                ["<esc>"] = actions.close,
                ["<CR>"] = actions.select_tab,
                -- ["<C-n>"] = actions.move_selection_previous,
                -- ["<C-p>"] = actions.move_selection_next,
                ["<C-o>"] = actions.select_default,
                -- maybe bug, don't take effect:
                -- ["<C-l>"] = actions.move_selection_next,
            },
        },
        -- layout_strategy = "cursor"
        -- sorting_strategy = 'ascending',
    },
    pickers = {
        find_files = {
            -- hidden = true,
            -- short_path = true,
            -- find_command = {'fd', '--hidden', "--type", "f", "--strip-cwd-prefix", '--exec-batch ls -l'}
            -- `sort` is not supported by fd, so replace fd with rg
            find_command = {
                "rg",
                "--sort=path",
                "--files",
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
                "--hidden",
                "--smart-case",
            },
        },
    },
}
