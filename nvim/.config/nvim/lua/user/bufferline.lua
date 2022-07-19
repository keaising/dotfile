local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
    return
end

vim.opt.termguicolors = true

bufferline.setup {
    options = {
        numbers = "ordinal",
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
    },
}
