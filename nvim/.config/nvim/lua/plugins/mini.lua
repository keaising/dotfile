return {
    {
        "echasnovski/mini.ai",
        version = "*",
        config = function()
            require("mini.ai").setup()
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
