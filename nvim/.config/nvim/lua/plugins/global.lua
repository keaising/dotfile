return {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
        "keaising/im-select.nvim",
        config = function()
            require("im_select").setup({
                -- default_im_select = "com.apple.keylayout.ABC",
                disable_auto_restore = 1,
                -- default_command = '/usr/local/bin/im-select'
            })
        end
    }
}
