local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- save & quit in window
keymap("i", "<A-s>", "<ESC>:w<CR>", opts)
keymap("n", "<A-s>", ":w<CR>", opts)
keymap("n", "<A-q>", ":qa<CR>", opts)
keymap("c", "sudow", "w !sudo tee % >/dev/null", opts)

-- resize window
keymap("n", "<A-Left>", ":vertical resize +5<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize -5<CR>", opts)
keymap("n", "<A-Up>", ":resize +5<CR>", opts)
keymap("n", "<A-Down>", ":resize -5<CR>", opts)

-- switch window
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)

-- switch location
keymap("n", "<A-[>", "<C-o>", opts)
keymap("n", "<A-]>", "<C-i>", opts)
-- for ssh to clinkz
keymap("n", "<ESC>[", "<C-o>", opts)
keymap("n", "<ESC>]", "<C-i>", opts)

-- move faster
keymap("n", "<C-e>", "9<C-e>", opts)
keymap("n", "<C-y>", "9<C-y>", opts)

-- move in insert mode
keymap("i", "<A-h>", "<left>", opts)
keymap("i", "<A-j>", "<down>", opts)
keymap("i", "<A-k>", "<up>", opts)
keymap("i", "<A-l>", "<right>", opts)
keymap("i", "<A-b>", "<C-o>b", opts)
keymap("i", "<A-w>", "<C-o>w", opts)
keymap("i", "<A-e>", "<C-o>e", opts)

-- Keep search pattern at the center of the screen.
keymap("n", "n", "nzz", opts)
keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "<Tab>", "%", opts)
keymap("n", "<Tab>", "%", opts)

-- move to line start/end
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)

-- " mark
keymap("n", "'", "`", opts)

-- " close all recursively
keymap("n", "zm", "zM", opts)
-- " open current recursively
keymap("n", "zo", "zO", opts)
-- " open all recursively
keymap("n", "zr", "zR", opts)
-- " close current: zc
-- " open/close current: za

-- " disable
keymap("n", "<C-p>", "<nop>", opts)

-- " search selected content in visual mode: https://blog.twofei.com/610/
keymap("v", "//", 'y/<c-r>"<cr>', opts)
keymap("n", "//", ':noh<CR>', opts)

-- " insert mode specials
keymap("i", ";;", ":=", opts)

keymap("n", "<leader>sv", ":PackerSync<CR>", opts)

-- bufferline
keymap("n", "<m-{>", ":BufferLineCyclePrev<CR>", opts)
keymap("n", "<m-}>", ":BufferLineCycleNext<CR>", opts)
keymap("n", "<m-<>", ":BufferLineMovePrev<CR>", opts)
keymap("n", "<m->>", ":BufferLineMoveNext<CR>", opts)
keymap("n", "<leader>wh", ":BufferLineCloseLeft<CR>", opts)
keymap("n", "<leader>wl", ":BufferLineCloseRight<CR>", opts)
keymap("n", "<m-e>", ":BufferLinePick<CR>", opts)

-- bufdelete
keymap("n", "<A-w>", ":Bdelete<CR>", opts)

-- telescope
keymap("n", "<leader>ss", ":Telescope find_files<CR>", opts)
keymap("n", "<leader>ff", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>fb", ":Telescope buffers<CR>", opts)
keymap("n", "<leader>fh", ":Telescope help_tags<CR>", opts)
