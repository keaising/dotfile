set hlsearch
set noswapfile
set hidden
set autowrite
set clipboard=unnamed,unnamedplus " y/d/c copy to/from system clipboard
set autoindent
set winaltkeys=no                 " Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
set ruler                         " 显示光标位置
set autoread                      " auto reload when file on disk changed
set ignorecase                    " 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
set smartcase
set hlsearch                      " 高亮搜索内容
set incsearch                     " 查找输入时动态增量显示查找结果
set showmatch                     " 显示匹配的括号
set display=lastline              " 显示最后一行
set wildmenu                      " 允许下方显示目录
set formatoptions+=B              " 合并两行中文时，不在中间加空格
set ffs=unix,dos,mac              " 文件换行符，默认使用 unix 换行符
set foldenable                    " 允许代码折叠
set fdm=indent                    " 代码折叠默认使用缩进
set foldlevel=99                  " 默认打开所有缩进
set tabstop=4       " tab size
set shiftwidth=4
set laststatus=2    " 总是显示状态栏
set number          " 总是显示行号
set relativenumber
set signcolumn=yes  " 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
set colorcolumn=88  " 显示列宽
set showtabline=2   " 总是显示标签栏
set listchars=tab:\|\ ,trail:.,extends:>,precedes:< " 设置分隔符可视
set list            " 设置显示制表符等隐藏字符
set showcmd         " 右下角显示命令
set splitright     " 水平切割窗口时，默认在右边显示新窗口
set background=dark " 设置黑色背景
set fileencoding=utf-8                                         " 文件默认编码
set t_Co=256        " 允许256色
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors
set paste


syntax enable
syntax on


map <Space> <Leader>

inoremap <ESC>s <ESC>:w<CR>
nnoremap <ESC>s :w<CR>
nnoremap <ESC>q :qa<CR>
nnoremap <C-q>  <C-w>q
nnoremap <ESC>w :q<CR>

" resize window
nnoremap <ESC>[1;3D :vertical resize +5<CR>
nnoremap <ESC>[1;3C :vertical resize -5<CR>
nnoremap <ESC>[1;3B :resize   +5<CR>
nnoremap <ESC>[1;3A :resize   -5<CR>

" faster movement
nnoremap <C-e> 9<C-e>
nnoremap <C-y> 9<C-y>

" Keep search pattern at the center of the screen.
nnoremap <silent> n     nzz
nnoremap <silent> j     gj
nnoremap <silent> k     gk
nnoremap <silent> N     Nzz
nnoremap <silent> *     *zz
nnoremap <silent> #     #zz
nnoremap <silent> g*    g*zz
nnoremap <silent> <Tab> %
vnoremap <silent> <Tab> %

" move to line start/end
noremap  H ^
noremap  L $
" mark
nnoremap ' `

" search selected content in visual mode: https://blog.twofei.com/610/
vnoremap //         y/<c-r>"<cr>
nnoremap <leader>// :noh<CR>

" save file with sudo
cnoremap sudow w !sudo tee % >/dev/null

colorscheme slate
