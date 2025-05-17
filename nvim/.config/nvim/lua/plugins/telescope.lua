-- begin 当年闲的蛋疼弄的
local entry_display = require("telescope.pickers.entry_display")
local displayer = entry_display.create({
    separator = " ",
    items = {
        { width = 4 },
        { width = nil },
        { width = nil },
        { width = nil },
    },
})
local function trim_folder_prefix(s)
    local prefix = vim.fn.expand("~/code/")
    if vim.startswith(s, prefix) then
        return string.sub(s, #prefix + 1)
    end
    return s
end
local function make_entry(entry)
    local utils = require("telescope.utils")
    return {
        value = entry.filename,
        display = function(item)
            local colors = {
                ["ERROR"] = "Red",
                ["WARN"] = "Purple",
                ["INFO"] = "Yellow",
                ["HINT"] = "Blue",
            }
            return displayer({
                { string.format("%4d", item.lnum), colors[entry.type] },
                { trim_folder_prefix(utils.transform_path({}, item.filename)), "" },
                {
                    string.format("%s> %s", string.lower(string.sub(item.type, 1, 1)), item.text),
                    colors[entry.type],
                },
            })
        end,
        filename = entry.filename,
        ordinal = utils.transform_path({}, entry.filename) .. entry.type,
        lnum = entry.lnum,
        col = entry.col,
        type = entry.type,
        text = entry.text,
    }
end
-- end

return {
    {
        "nvim-telescope/telescope.nvim",
        -- dir = "/home/taiga/code/github.com/nvim-telescope/telescope.nvim",
        -- dev = true,
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            -- mappings
            local bufopts = { noremap = true, silent = true }
            local builtin = require("telescope.builtin")
            -- vim.keymap.set("n", "<leader>s", function()
            --     builtin.find_files()
            -- end, bufopts)
            -- vim.keymap.set("n", "<leader>f", function()
            --     builtin.live_grep()
            -- end, bufopts)
            -- vim.keymap.set("n", "<C-f>", function()
            --     builtin.current_buffer_fuzzy_find()
            -- end, bufopts)
            -- vim.keymap.set("n", "<leader>lo", function()
            --     builtin.oldfiles({
            --         cwd_only = true,
            --         sorting_strategy = "ascending",
            --     })
            -- end, bufopts)
            -- vim.keymap.set("n", "<CR>", function()
            --     builtin.resume()
            -- end, bufopts)
            -- vim.keymap.set("n", "<leader>ld", function()
            --     builtin.diagnostics({
            --         entry_maker = make_entry,
            --     })
            -- end, bufopts)
            -- vim.keymap.set("n", "<leader>lj", function()
            --     builtin.jumplist({ show_line = false })
            -- end, bufopts)

            -- vim.keymap.set("n", "<leader>lg", function()
            --     local previewers = require("telescope.previewers")
            --     local opts = { current_file = vim.fn.expand("%") }
            --     builtin.git_bcommits({
            --         git_command = { "gitlog_ts" }, -- 这玩意至今还有bug没有修,还需要搭配脚本使用,也是闲的蛋疼弄的,
            --         previewer = {
            --             previewers.git_commit_diff_to_parent.new(opts),
            --             previewers.git_commit_message.new(opts),
            --             previewers.git_commit_diff_as_was.new(opts),
            --             previewers.git_commit_diff_to_head.new(opts),
            --         },
            --     })
            -- end, bufopts)

            -- settings
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    vimgrep_arguments = {
                        "rg",
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
                            ["<CR>"] = actions.select_default,
                            ["<C-o>"] = actions.select_default,
                            ["<C-y>"] = actions.preview_scrolling_up,
                            ["<C-e>"] = actions.preview_scrolling_down,
                            ["<C-s>"] = actions.cycle_previewers_next,
                            ["<C-a>"] = actions.cycle_previewers_prev,
                        },
                    },
                    sorting_strategy = "ascending",
                    layout_strategy = "bottom_pane",
                    border = true,
                    borderchars = {
                        prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
                        results = { " " },
                        preview = { "─", " ", "─", "│", "┌", "─", "─", "└" },
                    },
                    layout_config = {
                        width = 1.0,
                        height = 0.6,
                        preview_width = 0.45,
                    },
                },
                pickers = {
                    find_files = {
                        find_command = {
                            "rg",
                            "--sort=path",
                            "--files",
                            "--no-heading",
                            "--with-filename",
                            "--line-number",
                            "--column",
                            "--hidden",
                            "--smart-case",
                        },
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            require("telescope").load_extension("ui-select")
        end,
    },
}
