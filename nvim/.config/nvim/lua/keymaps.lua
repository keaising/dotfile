local map = vim.keymap.set

vim.g.move_map_keys = 0

-- nerdcommenter
vim.g.NERDDefaultAlign = "left"
vim.g.NERDSpaceDelims = 1
vim.g.NERDAllowAnyVisualDelims = 0
vim.g.NERDCreateDefaultMappings = 0

-- kshenoy/vim-signature
vim.g.SignatureMap = {
    GotoNextSpotAlpha = "",
    GotoPrevSpotAlpha = "",
}

-- save & quit in window
map("i", "<m-s>", "<ESC>:wa<CR>")
map("n", "<m-s>", ":wa<CR>")
map("n", "<C-s>", ":w<CR>")
map("n", "<m-q>", ":qa<CR>")
map("n", "<C-q>", ":q<CR>")
-- save file with sudo
map("c", "sudow", "w !sudo tee % >/dev/null")

-- switch window
map({ "n", "v", "o" }, "<C-h>", "<c-w>h")
map({ "n", "v", "o" }, "<C-l>", "<c-w>l")
map({ "n", "v", "o" }, "<C-j>", "<c-w>j")
map({ "n", "v", "o" }, "<C-k>", "<c-w>k")

-- split window
map({ "n", "v", "o" }, "<leader>vs", ":vsplit<CR>")
map({ "n", "v", "o" }, "<leader>hs", ":split<CR>")

-- switch location
map({ "n", "v", "o" }, "<m-[>", "<C-o>")
map({ "n", "v", "o" }, "<m-]>", "<C-i>")

-- faster movement
map("n", "<C-e>", "9<C-e>")
map("n", "<C-y>", "9<C-y>")

-- move in insert mode
map("i", "<m-h>", "<left>")
map("i", "<m-j>", "<down>")
map("i", "<m-k>", "<up>")
map("i", "<m-l>", "<right>")
map("i", "<m-b>", "<C-o>b")
map("i", "<m-w>", "<C-o>w")
map("i", "<m-e>", "<C-o>e")
map("i", "<m-BS>", "<C-w>")

-- Keep search pattern at the center of the screen.
map("n", "n", "nzzzv", { silent = true })
map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })
map("n", "N", "Nzzzv", { silent = true })
map("n", "*", "*zz", { silent = true })
map("n", "#", "#zz", { silent = true })
map("n", "g*", "g*zz", { silent = true })
map("n", "<Tab>", "%", { silent = true })
map("v", "<Tab>", "%", { silent = true })

-- come from https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
map("n", "J", "mzJ`z", { silent = true })
map("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- don't follow vim default behavior
map("x", "p", "P")

map("n", "<leader>x", ":silent !chmod +x %<CR>")

-- select all
map("n", "ga", "ggVG")

-- move to line start/end
map({ "n", "v", "o" }, "H", "^")
map({ "n", "v", "o" }, "L", "$")

-- plus/minus
map({ "n", "v", "o" }, "=", "<C-a>")
map({ "n", "v", "o" }, "-", "<C-x>")

-- run macro q/w
map("n", "<A-2>", "@q")
map("n", "<A-3>", "@w")

-- mark
map("n", "'", "`")

-- toggle current block, all level
map("n", "zo", "zA")

-- disable
map("n", "<C-p>", "<nop>")

-- search selected content in visual mode: https://blog.twofei.com/610/
map("v", "//", 'y/<c-r>"<cr>')
map("n", "<leader>/", ":noh<CR>")

-- insert mode specials
map("i", ";;", ":=")

-- resource configuration
map("n", "<leader>la", ":Lazy<CR>")

-- buffer
map("n", "<m-h>", ":BufferLineCyclePrev<CR>", { silent = true })
map("n", "<m-l>", ":BufferLineCycleNext<CR>", { silent = true })
map("n", "<m-H>", ":BufferLineMovePrev<CR>", { silent = true })
map("n", "<m-L>", ":BufferLineMoveNext<CR>", { silent = true })
map("n", "<leader>wh", ":BufferLineCloseLeft<CR>", { silent = true })
map("n", "<leader>wl", ":BufferLineCloseRight<CR>", { silent = true })
map("n", "<leader>wa", ":BufferLineCloseOthers<CR>", { silent = true })
map("n", "<m-e>", ":BufferLinePick<CR>", { silent = true })
map("n", "<m-w>", function()
    require("mini.bufremove").delete(0, false)
end, { silent = true })

-- easy align
map("x", "ga", "<Plug>(EasyAlign)")
map("v", "gs", ":EasyAlign")

-- vim-move
map("n", "<C-A-h>", "<Plug>MoveCharLeft", { silent = true })
map("n", "<C-A-l>", "<Plug>MoveCharRight", { silent = true })
map("n", "<C-A-j>", "<Plug>MoveLineDown", { silent = true })
map("n", "<C-A-k>", "<Plug>MoveLineUp", { silent = true })
map("v", "<C-A-h>", "<Plug>MoveBlockLeft", { silent = true })
map("v", "<C-A-l>", "<Plug>MoveBlockRight", { silent = true })
map("v", "<C-A-j>", "<Plug>MoveBlockDown", { silent = true })
map("v", "<C-A-k>", "<Plug>MoveBlockUp", { silent = true })

-- vim maximizer
local maximize_restore = nil
local function toggle_maximize()
    if maximize_restore then
        vim.cmd("silent! " .. maximize_restore)
        maximize_restore = nil
    else
        maximize_restore = vim.fn.winrestcmd()
        vim.cmd("silent! vertical resize " .. vim.o.columns)
        vim.cmd("silent! resize " .. vim.o.lines)
    end
end
map("n", "<C-z>", toggle_maximize, { silent = true })
map("v", "<C-z>", toggle_maximize, { silent = true })
map("i", "<C-z>", toggle_maximize, { silent = true })

map("n", "<leader>cc", "<plug>NERDCommenterToggle")
map("v", "<leader>cc", "<plug>NERDCommenterToggle")
map("n", "<M-/>", "<plug>NERDCommenterToggle")
map("v", "<M-/>", "<plug>NERDCommenterToggle")

-- lsp
map("n", "<leader>lr", ":LspStop<CR>:LspStart<CR>:LspRestart<CR>")

-- kylechui/nvim-surround
map("o", "ir", "i[")
map("o", "ar", "a[")
map("x", "ir", "i[")
map("x", "ar", "a[")

-- YankAssassin replacement: keep cursor position after yanking
local pre_yank_pos = vim.fn.getpos(".")
vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
        pre_yank_pos = vim.fn.getpos(".")
    end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        if vim.v.event.operator == "y" and vim.g.MoveYankMappings ~= 0 and pre_yank_pos then
            vim.fn.setpos(".", pre_yank_pos)
        end
        vim.g.MoveYankMappings = 1
    end,
})
