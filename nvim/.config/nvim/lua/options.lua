vim.g.clipboard = "osc52"

vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 0
vim.opt.hidden = true
vim.opt.autowrite = true
vim.opt.winaltkeys = "no"
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 50
vim.opt.updatetime = 300
vim.opt.ruler = true
vim.opt.autoread = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.showmatch = true
vim.opt.matchtime = 2
vim.opt.display = "lastline"
vim.opt.wildmenu = true
vim.opt.backup = true
vim.opt.writebackup = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.list = true
vim.opt.showcmd = true
vim.opt.splitright = true
vim.opt.laststatus = 2
vim.opt.showtabline = 2
vim.opt.shortmess:append("c")
vim.opt.whichwrap:append("<,>,[,],h,l")
vim.opt.iskeyword:remove("-")
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "88"
vim.opt.formatoptions:append("B")
vim.opt.fileformats = "unix,dos,mac"
vim.opt.backupdir = "~/.vim/tmp"
vim.opt.backupext = ".bak"
vim.opt.mouse = ""
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = "~/.vim/undo//"
vim.fn.mkdir(vim.fn.expand("~/.vim/undo"), "p")
vim.opt.spelloptions = "camel"
vim.opt.splitbelow = true
vim.opt.listchars = "lead:⋅,tab:▸ ,trail:."
vim.opt.clipboard:prepend("unnamed,unnamedplus")
vim.opt.foldenable = true
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 99

-- 恢复上次打开位置
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local last = vim.api.nvim_buf_line_count(0)
        if mark[1] > 1 and mark[1] <= last then
            vim.cmd('normal! g`"')
        end
    end,
})
