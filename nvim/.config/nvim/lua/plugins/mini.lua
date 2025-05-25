return {
    {
        "echasnovski/mini.ai",
        version = "*",
        config = function()
            require("mini.ai").setup({
                n_lines = 1000,
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
}
