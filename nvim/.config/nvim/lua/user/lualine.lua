local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
    return
end

lualine.setup {
    options = {
        theme = "jellybeans",
        component_separators = {
            left = " ",
            right = " ",
        },
        section_separators = {
            left = " ",
            right = " ",
        },
    },
    sections = {
        lualine_c = {
            {
                "filename",
                path = 1, -- show relative path
                symbols = {
                    modified = "[+]", -- Text to show when the file is modified.
                    readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
                    unnamed = "[No Name]", -- Text to show for unnamed buffers.
                },
            },
        },
    },
}
