" basic -----{{{

set autoindent
set cursorline
set showmatch
set hlsearch
set noswapfile
set hidden
set autowrite
set clipboard=unnamed,unnamedplus " y/d/c copy to/from system clipboard
set autoindent
set winaltkeys=no                 " Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
set ttimeout                      " 功能键超时检测 50 毫秒
set timeoutlen=800
set ttimeoutlen=5
set ruler                         " 显示光标位置
set autoread                      " auto reload when file on disk changed
set ignorecase                    " 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
set smartcase
set hlsearch                      " 高亮搜索内容
set incsearch                     " 查找输入时动态增量显示查找结果
set showmatch                     " 显示匹配的括号
set matchtime=2                   " 显示括号匹配的时间
set display=lastline              " 显示最后一行
set wildmenu                      " 允许下方显示目录
set formatoptions+=B              " 合并两行中文时，不在中间加空格
set ffs=unix,dos,mac              " 文件换行符，默认使用 unix 换行符
set foldenable                    " 允许代码折叠
set fdm=indent                    " 代码折叠默认使用缩进
set foldlevel=99                  " 默认打开所有缩进
set backup                        " 允许备份
set writebackup                   " 保存时备份

syntax enable
syntax on
let &t_SI="\e[6 q" "切换光标
let &t_EI="\e[2 q"
au CursorHold * checktime
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m " 错误格式
set listchars=tab:\|\ ,trail:.,extends:>,precedes:< " 设置分隔符可视

set fileencoding=utf-8                                         " 文件默认编码
set fileencodings=ucs-bom,utf-8,gbk,gb18030,big5,euc-jp,latin1 " 打开文件时自动尝试下面顺序的编码
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android


" }}}



" file type -----{{{ 

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    " edit vimrc
    :nnoremap <leader>ev :vsplit $MYVIMRC<cr>
    :nnoremap <leader>sv :source $MYVIMRC<cr>
    autocmd FileType vim :iabbrev <buffer> --- -----{{{
augroup END
" }}} 




" }}}



" config -----{{{
 

" 打开文件时恢复上一次光标所在位置
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\	 exe "normal! g`\"" |
	\ endif

" }}}



" key map -----{{{ 

" Leader key
map <Space> <Leader>

" save & quit in window
inoremap <ESC>s <ESC>:w<CR>
nnoremap <ESC>s :w<CR>
nnoremap <ESC>q :qa<CR>
nnoremap <ESC>w :q<CR>

" resize window
nnoremap <ESC>[1;3D :vertical resize +5<CR>
nnoremap <ESC>[1;3C :vertical resize -5<CR>
nnoremap <ESC>[1;3B :resize   +5<CR>
nnoremap <ESC>[1;3A :resize   -5<CR>

" switch tabs
nnoremap <ESC>{ :tabprevious<CR>
nnoremap <ESC>} :tabnext<CR>

" faster movement
nnoremap <C-e> 9<C-e>
nnoremap <C-y> 9<C-y>

" move in insert mode
inoremap <ESC>h <left>
inoremap <ESC>j <down>
inoremap <ESC>k <up>
inoremap <ESC>l <right>
inoremap <ESC>b <C-o>b
inoremap <ESC>w <C-o>w
inoremap <ESC>e <C-o>e

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

" fold
nmap zo zO
" nmap zr zR
nmap zo zO
" nmap zm zM
nmap zm zM
" zm will fold current block

" disable 
nnoremap <C-p> <nop>

" insert mode specials
inoremap ;; :=

" search selected content in visual mode: https://blog.twofei.com/610/
vnoremap //         y/<c-r>"<cr>
nnoremap <leader>// :noh<CR>

nnoremap <leader>sv :source $MYVIMRC<CR>

" save file with sudo
cnoremap sudow w !sudo tee % >/dev/null

" }}}



" style ------------------------ {{{

set tabstop=4       " tab size
set shiftwidth=4
set laststatus=2    " 总是显示状态栏
set number          " 总是显示行号
set relativenumber
set signcolumn=yes  " 总是显示侧边栏（用于显示 mark/gitdiff/诊断信息）
set colorcolumn=88  " 显示列宽
set showtabline=2   " 总是显示标签栏
set list            " 设置显示制表符等隐藏字符
set showcmd         " 右下角显示命令
set splitright      " 水平切割窗口时，默认在右边显示新窗口
set updatetime=800
set autoindent
set background=dark " 设置黑色背景
set t_Co=256        " 允许256色

let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set termguicolors

colorscheme slate
" }}}
