return {
    {
        "echasnovski/mini.ai",
        version = "*",
        config = function()
            local ai = require("mini.ai")
            ai.setup({
                n_lines = 1000,
                custom_textobjects = {
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                    c = ai.gen_spec.treesitter({ a = "@call_expression", i = "@call_expression" }),
                    e = ai.gen_spec.treesitter({ a = "@expression_list", i = "@expression_list" }),
                    k = ai.gen_spec.treesitter({ a = "@keyed_element", i = "@keyed_element" }),
                },
            })
        end,
    },
    {
        "echasnovski/mini.splitjoin",
        config = function()
            require("mini.splitjoin").setup({
                mappings = {
                    toggle = ",",
                },
            })
        end,
    },
    {
        "echasnovski/mini.bufremove",
        config = function()
            require("mini.bufremove").setup({})
        end,
    },
}
