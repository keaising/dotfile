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

" different cursor shape in normal/insert mode
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"


syntax enable
syntax on


" support Alt
function! Terminal_MetaMode(mode)
    set ttimeout
    if $TMUX != ''
        set ttimeoutlen=30
    elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
        set ttimeoutlen=80
    endif
    if has('nvim') || has('gui_running')
        return
    endif
    function! s:metacode(mode, key)
        if a:mode == 0
            exec "set <M-".a:key.">=\e".a:key
        else
            exec "set <M-".a:key.">=\e]{0}".a:key."~"
        endif
    endfunc
    for i in range(10)
        call s:metacode(a:mode, nr2char(char2nr('0') + i))
    endfor
    for i in range(26)
        call s:metacode(a:mode, nr2char(char2nr('a') + i))
        call s:metacode(a:mode, nr2char(char2nr('A') + i))
    endfor
    if a:mode != 0
        for c in [',', '.', '/', ';', '[', ']', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    else
        for c in [',', '.', '/', ';', '{', '}']
            call s:metacode(a:mode, c)
        endfor
        for c in ['?', ':', '-', '_']
            call s:metacode(a:mode, c)
        endfor
    endif
endfunc
call Terminal_MetaMode(0)


map <Space> <Leader>

inoremap <M-s> <ESC>:w<CR>
nnoremap <M-s> :w<CR>
nnoremap <M-q> :qa<CR>
nnoremap <C-q>  <C-w>q
nnoremap <M-w> :q<CR>

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

nnoremap <leader>nn :set nu! <bar> set rnu! <bar> set signcolumn=no<CR>

colorscheme slate
