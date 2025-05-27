local rg_opts = table.concat({
    -- "--column",
    "--line-number",
    "--no-heading",
    "--color=always",
    "--smart-case",
    "--max-columns=4096",
    "-j1",
    "--hidden",
    "-g '!{.git,node_modules}/'",
    "--fixed-strings",
    "--sort path",
    -- "-e",
}, " ")

return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            {
                "<leader>s",
                function()
                    require("fzf-lua").files()
                end,
            },
            {
                "<leader>f",
                function()
                    require("fzf-lua").live_grep({
                        rg_opts = rg_opts,
                        multiline = 2,
                    })
                end,
            },
            {
                "<A-f>",
                function()
                    require("fzf-lua").blines({
                        previewer = false,
                    })
                end,
            },
            {
                "<CR>",
                function()
                    require("fzf-lua").resume()
                end,
            },
            {
                "<leader>lo",
                function()
                    require("fzf-lua").oldfiles()
                end,
            },
            {
                "<leader>dd",
                function()
                    require("fzf-lua").diagnostics_document({
                        multiline = 2,
                    })
                end,
            },
            {
                "<leader>dw",
                function()
                    require("fzf-lua").diagnostics_workspace({
                        multiline = 2,
                    })
                end,
            },
            {
                "<leader>gw",
                function()
                    require("fzf-lua").grep_cword()
                end,
            },
        },
        config = function()
            local fzf = require("fzf-lua")
            fzf.register_ui_select()
            fzf.setup({
                "hide",
                winopts = {
                    row = 1,
                    height = 0.62,
                    width = 1.0,
                    preview = {
                        border = "single",
                        horizontal = "right:45%",
                        wrap = true,
                    },
                    border = "single",
                },
                fzf_opts = {
                    ["--cycle"] = true,
                    ["--no-scrollbar"] = true,
                },
                lsp = {
                    jump1 = true,
                    includeDeclaration = false,
                    ignore_current_line = true,
                    unique_line_items = true,
                    code_actions = { previewer = "codeaction_native" },
                },
            })
        end,
    },
}
