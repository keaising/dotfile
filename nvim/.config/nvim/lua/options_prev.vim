" cSpell:disable
set autoindent
set tabstop=4            " 按下 Tab 键时，Vim 显示的空格数
set shiftwidth=4
set softtabstop=0        " 关闭softtabstop 永远不要将空格和tabset cursorline
set hidden
set autowrite
set winaltkeys=no        " Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
set ttimeout             " 功能键超时检测 50 毫秒
set ttimeoutlen=50
set updatetime=300
set ruler                " 显示光标位置
set autoread             " auto reload when file on disk changed
set ignorecase           " 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
set smartcase            "
set incsearch            " 查找输入时动态增量显示查找结果
set showmatch            " 显示匹配的括号
set matchtime=2          " 显示括号匹配的时间
set display=lastline     " 显示最后一行
set wildmenu             " 允许下方显示目录
set fdm=indent           " 代码折叠默认使用缩进
set backup               " 允许备份
set writebackup          " 保存时备份
set scrolloff=5          " 垂直滚动时，光标距离顶部/底部的位置（单位：行）
set sidescrolloff=15     " 水平滚动时，光标距离行首或行尾的位置（单位：字符）
set relativenumber
set number
set list                 " 设置显示制表符等隐藏字符
set showcmd              " 右下角显示命令
set splitright           " 水平切割窗口时，默认在右边显示新窗口
set laststatus=2         " 总是显示状态栏
set showtabline=2        " 总是显示标签栏
set shortmess+=c         " https://stackoverflow.com/a/25102964
set whichwrap+=<,>,[,],h,l
set iskeyword-=-
set signcolumn=yes       " 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
set colorcolumn=88       " 显示列宽
set formatoptions+=B     " 合并两行中文时，不在中间加空格
set ffs=unix,dos,mac     " 文件换行符，默认使用 unix 换行符
set backupdir=~/.vim/tmp " 备份文件地址，统一管理
set backupext=.bak       " 备份文件扩展名
set mouse=
set noswapfile
set noundofile
set spo=camel
set splitbelow
set splitright
set listchars=lead:⋅,tab:\▸\ ,trail:. " 设置分隔符可视
set clipboard^=unnamed,unnamedplus                  " y/d/c copy to/from system clipboard
set foldenable
set foldlevelstart=99
set foldlevel=99                                    " 默认打开所有缩进
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" 恢复上次打开位置
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\	 exe "normal! g`\"" |
	\ endif

augroup filetypes
	autocmd!
	autocmd FileType fish            setlocal expandtab
	autocmd FileType go              setlocal tabstop=4      shiftwidth=4      noexpandtab
	autocmd FileType javascript      setlocal tabstop=2      shiftwidth=2      expandtab
	autocmd FileType javascriptreact setlocal tabstop=2      shiftwidth=2      expandtab
	autocmd FileType json            setlocal tabstop=2      shiftwidth=2      expandtab
	autocmd FileType lua             setlocal foldmarker={,} foldmethod=marker expandtab
	autocmd FileType python          setlocal tabstop=4      shiftwidth=4      expandtab
	autocmd FileType tmux            setlocal foldmethod=marker
	autocmd FileType typescript      setlocal tabstop=2      shiftwidth=2      expandtab
	autocmd FileType typescriptreact setlocal tabstop=2      shiftwidth=2      expandtab
	autocmd FileType zsh             setlocal foldmethod=marker
augroup END
