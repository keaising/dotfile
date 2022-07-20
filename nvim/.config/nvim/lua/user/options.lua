local options = {
    autoindent     = true,
    tabstop        = 4, --按下 Tab 键时，Vim 显示的空格数
    shiftwidth     = 4,
    softtabstop    = 0, --关闭softtabstop 永远不要将空格和tab混合输入
    cursorline     = true,
    hidden         = true,
    autowrite      = true,
    clipboard      = "unnamed,unnamedplus", -- y/d/c copy to/from system clipboard
    winaltkeys     = "no", -- Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
    ttimeout       = true, -- 功能键超时检测 50 毫秒
    ttimeoutlen    = 50,
    updatetime     = 300,
    ruler          = true, -- 显示光标位置
    autoread       = true, -- auto reload when file on disk changed
    ignorecase     = true, -- 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
    smartcase      = true,
    hlsearch       = true, -- 高亮搜索内容
    incsearch      = true, -- 查找输入时动态增量显示查找结果
    showmatch      = true, -- 显示匹配的括号
    matchtime      = 2, -- 显示括号匹配的时间
    display        = "lastline", -- 显示最后一行
    wildmenu       = true, -- 允许下方显示目录
    foldenable     = true, -- 允许代码折叠
    fdm            = "indent", -- 代码折叠默认使用缩进
    foldlevel      = 99, -- 默认打开所有缩进
    backup         = true, -- 允许备份
    writebackup    = true, -- 保存时备份
    scrolloff      = 5, --垂直滚动时，光标距离顶部/底部的位置（单位：行）
    sidescrolloff  = 15, --水平滚动时，光标距离行首或行尾的位置（单位：字符）。该配置在不折行时比较有用
    relativenumber = true,
    number         = true,
    laststatus     = 2, --  总是显示状态栏
    showtabline    = 2, --  总是显示标签栏
    list           = true, --  设置显示制表符等隐藏字符
    showcmd        = true, --  右下角显示命令
    splitright     = true, --  水平切割窗口时，默认在右边显示新窗口
}


vim.opt.shortmess:append "c"

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd [[
set whichwrap+=<,>,[,],h,l
set iskeyword+=- 
set signcolumn=yes  "  总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
set colorcolumn=88  "  显示列宽
set formatoptions+=B " 合并两行中文时，不在中间加空格
set ffs=unix,dos,mac " 文件换行符，默认使用 unix 换行符
set backupdir=~/.vim/tmp " 备份文件地址，统一管理
set backupext=.bak " 备份文件扩展名
set noswapfile
set noundofile
set t_Co=256        " 允许256色
]]
