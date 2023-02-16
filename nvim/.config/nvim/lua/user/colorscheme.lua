-- local colorscheme = "dracula"
-- local colorscheme = "kanagawa"
-- local colorscheme = "sonokai"
-- vim.cmd [[ 
--         let g:sonokai_style = 'shusia'
--         let g:sonokai_better_performance = 1
-- ]]
-- local colorscheme = "gruvbox-material"
local colorscheme = "xcodedark"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
    vim.notify("colorscheme " .. colorscheme .. " not found!")
    return
end
