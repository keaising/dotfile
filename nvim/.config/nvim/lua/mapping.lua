return function(packer)
	vim.opt.autoindent = true
	vim.opt.tabstop = 4 -- "按下 Tab 键时，Vim 显示的空格数
	vim.opt.shiftwidth = 4
	vim.opt.softtabstop = 0 -- "关闭softtabstop 永远不要将空格和tab混合输入
	vim.opt.cursorline = true
	vim.opt.showmatch = true
	vim.opt.hlsearch = true
	vim.opt.hidden = true
	vim.opt.autowrite = true
	vim.opt.clipboard = { "unnamed", "unnamedplus" } -- " y/d/c copy to/from system clipboard
	vim.opt.winaltkeys = "no" -- " Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
	vim.opt.ttimeout = true -- " 功能键超时检测 50 毫秒
	vim.opt.ttimeoutlen = 50
	vim.opt.ruler = true -- " 显示光标位置
	vim.opt.autoread = true -- " auto reload when file on disk changed
	vim.opt.ignorecase = true -- " 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
	vim.opt.smartcase = true
	vim.opt.hlsearch = true -- " 高亮搜索内容
	vim.opt.incsearch = true -- " 查找输入时动态增量显示查找结果
	vim.opt.showmatch = true -- " 显示匹配的括号
	vim.opt.matchtime = 2 -- " 显示括号匹配的时间
	vim.opt.display = "lastline" -- " 显示最后一行
	vim.opt.wildmenu = true -- " 允许下方显示目录
	-- vim.opt.formatoptions+=B              -- " 合并两行中文时，不在中间加空格
	vim.opt.ffs = "unix,dos,mac" -- " 文件换行符，默认使用 unix 换行符
	vim.opt.foldenable = true -- " 允许代码折叠
	vim.opt.fdm = "indent" -- " 代码折叠默认使用缩进
	vim.opt.foldlevel = 99 -- " 默认打开所有缩进
	vim.opt.backup = true -- " 允许备份
	vim.opt.writebackup = true -- " 保存时备份
	-- vim.opt.backupdir = "~/.vim/tmp" -- " 备份文件地址，统一管理
	vim.opt.backupext = ".bak" -- " 备份文件扩展名
	-- vim.opt.noswapfile = true -- " 禁用交换文件
	-- vim.opt.noundofile = true -- " 禁用 undo文件
	vim.opt.scrolloff = 5 -- "垂直滚动时，光标距离顶部/底部的位置（单位：行）
	vim.opt.sidescrolloff = 15 -- "水平滚动时，光标距离行首或行尾的位置（单位：字符）。该配置在不折行时比较有用

	vim.cmd("syntax enable")
	vim.cmd("syntax on")
	vim.cmd('let &t_SI="\\e[6 q" ')
	vim.cmd('let &t_EI="\\e[2 q"')

	vim.cmd("au CursorHold * checktime")
	vim.cmd("set errorformat+=[%f:%l]\\ ->\\ %m,[%f:%l]:%m") -- " 错误格式
	vim.cmd("set listchars=tab:\\|\\ ,trail:.,extends:>,precedes:<") -- " 设置分隔符可视

	local util = require("util")
	util.noremap("n", "<Space>", "<Leader>")

	-- " Leader key
	util.noremap("n", "<Space>", "<Nop>")
	vim.g.mapleader = " "
	vim.g.maplocalleader = " "

	-- " save & quit in window
	util.noremap("i", "<m-s>", "<ESC>:w<CR>")
	util.noremap("i", "<m-s>", "<ESC>:w<CR>")
	util.noremap("i", "<m-w>", "<ESC>:q<CR>")

	-- " save & quit editor
	util.noremap("n", "<Space>wa", ":wa<CR>")
	util.noremap("n", "<M-q>", ":qa<CR>")
	util.noremap("n", "<M-s>", ":wa<CR>")
	util.noremap("n", "<M-w>", "<C-w>q")
	util.noremap("n", "<C-n>", ":NvimTreeToggle<CR><C-w>w")

	-- " resize window
	util.noremap("n", "<m-Left>", ":vertical resize +5<CR>")
	util.noremap("n", "<m-Right>", ":vertical resize -5<CR>")
	util.noremap("n", "<m-Up>", ":resize +5<CR>")
	util.noremap("n", "<m-Down>", ":resize -5<CR>")

	-- " switch tabs
	-- util.noremap('n', '<m-{>', ':tabprevious<CR>')
	-- util.noremap('n', '<m-}>', ':tabnext<CR>')
	util.noremap("n", "<M-l>", ":tabnext<CR>")
	util.noremap("n", "<M-h>", ":tabprevious<CR>")

	-- " switch window
	util.noremap("n", "<C-h>", "<C-w>h")
	util.noremap("n", "<C-l>", "<C-w>l")
	util.noremap("n", "<C-j>", "<C-w>j")
	util.noremap("n", "<C-k>", "<C-w>k")

	-- " switch location
	util.noremap("n", "<m-[>", "<C-o>")
	util.noremap("n", "<m-]>", "<C-i>")
	-- " for ssh to clinkz
	util.noremap("n", "<ESC>[", "<C-o>")
	util.noremap("n", "<ESC>]", "<C-i>")

	-- " faster movement
	util.noremap("n", "<C-e>", "9<C-e>")
	util.noremap("n", "<C-y>", "9<C-y>")

	-- " move in insert mode
	util.noremap("i", "<m-h>", "<left>")
	util.noremap("i", "<m-j>", "<down>")
	util.noremap("i", "<m-k>", "<up>")
	util.noremap("i", "<m-l>", "<right>")
	util.noremap("i", "<m-b>", "<C-o>b")
	util.noremap("i", "<m-w>", "<C-o>w")
	util.noremap("i", "<m-e>", "<C-o>e")

	util.noremap("n", "n", "nzz")
	util.noremap("n", "j", "gj")
	util.noremap("n", "k", "gk")
	util.noremap("n", "N", "Nzz")
	util.noremap("n", "*", "*zz")
	util.noremap("n", "#", "#zz")
	util.noremap("n", "g*", "g*zz")
	util.noremap("n", "<Tab>", "%")
	util.noremap("v", "<Tab>", "%")

	-- " move to line start/end
	util.noremap("n", "H", "^")
	util.noremap("n", "L", "$")

	-- " mark
	util.noremap("n", "'", "`")

	-- " close all recursively
	util.noremap("n", "zm", "zM", {
		noremap = false,
	})
	-- " open current recursively
	util.noremap("n", "zo", "zO", {
		noremap = false,
	})
	-- " open all recursively
	util.noremap("n", "zr", "zR", {
		noremap = false,
	})
	-- " close current: zc
	-- " open/close current: za

	-- " disable
	util.noremap("n", "<C-p>", "<nop>")

	-- " search selected content in visual mode: https://blog.twofei.com/610/
	util.noremap("v", "//", 'y/<c-r>"<cr>')
	util.noremap("n", "//", ":noh<CR>")

	-- " insert mode specials
	util.noremap("i", ";;", ":=")

	-- " resource configuration
	util.noremap("n", "<Space>sv", ":PackerSync<CR>")
	util.noremap("n", "<Space>si", ":PackerInstall<CR>")

	util.noremap("n", "<leader>sf", ":set filetype=")
	util.noremap("n", "<leader>st", ":set syntax=")

	-- " save file with sudo
	util.noremap("c", "sudow", "w !sudo tee % >/dev/null")
end
