return {
    {
        "kana/vim-textobj-user",
        priority = 100,
    },
    "kana/vim-textobj-function",
    "sgur/vim-textobj-parameter",
    "fvictorio/vim-textobj-backticks",
    "voldikss/vim-floaterm",
    "sbdchd/neoformat",
    {
        "junegunn/vim-easy-align",
        lazy = false,
    },
    "kshenoy/vim-signature", -- 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
    "tpope/vim-abolish", -- crs/crm/crc
    "terryma/vim-expand-region",
    "ruanyl/vim-gh-line",
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
}
