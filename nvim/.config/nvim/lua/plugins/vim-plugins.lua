return {
    "voldikss/vim-floaterm",
    {
        "junegunn/vim-easy-align",
        lazy = false,
    },
    "kshenoy/vim-signature", -- 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
    "tpope/vim-abolish", -- crs/crm/crc
    "preservim/nerdcommenter",
    "tpope/vim-repeat",
    "matze/vim-move",
    "szw/vim-maximizer",
    {
        "ojroques/vim-oscyank",
        tag = "v1.0.0", -- new version breaks, old version is good enough
    },
    {
        "fatih/vim-go",
        ft = "go",
        event = "VeryLazy",
    },
    -- https://github.com/buoto/gotests-vim/pull/10
    {
        "jakereps/gotests-vim",
        ft = "go",
        branch = "patch-1",
        event = "VeryLazy",
    },
    "svban/YankAssassin.vim",
    "AndrewRadev/sideways.vim",
    "prisma/vim-prisma",
}
