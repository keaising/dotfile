set cursorline
set showmatch
set hlsearch
set noswapfile
set hidden
" auto save
set autowrite

" tab size
set tabstop=4
set shiftwidth=4

" 总是显示状态栏
set laststatus=1

" 总是显示行号
set number
set relativenumber
" set nu!
" set rnu!

" 设置显示制表符等隐藏字符
set list

" 右下角显示命令
set showcmd

" 显示列宽
set colorcolumn=88

set splitright
set updatetime=800

" y/d/c copy to/from system clipboard
set clipboard=unnamed,unnamedplus
" 禁用 vi 兼容模式
set nocompatible
" 设置 Backspace 键模式
set bs=eol,start,indent
" 自动缩进
set autoindent
" 打开 C/C++ 语言缩进优化
set cindent
" Windows 禁用 ALT 操作菜单（使得 ALT 可以用到 Vim里）
set winaltkeys=no

" 显示光标位置
set ruler
" 切换光标
" autocmd InsertEnter,InsertLeave * set cul!
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" auto reload when file on disk changed
set autoread
au CursorHold * checktime  

set ignorecase
" 智能搜索大小写判断，默认忽略大小写，除非搜索内容包含大写字母
set smartcase

" 显示匹配的括号
set showmatch

" 错误格式
set errorformat+=[%f:%l]\ ->\ %m,[%f:%l]:%m

" 设置分隔符可视
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

"---------------------------------------------------
" 文件搜索和补全时忽略下面扩展名
"---------------------------------------------------
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


"----------------------------------------------------------------------
" 有 tmux 何没有的功能键超时（毫秒）
"----------------------------------------------------------------------
if $TMUX != ''
	set ttimeoutlen=30
elseif &ttimeoutlen > 80 || &ttimeoutlen <= 0
	set ttimeoutlen=80
endif

"----------------------------------------------------------------------
" key mapping
"----------------------------------------------------------------------
" Leader key
map      <Space>         <Leader>
" switch window
noremap  <C-h> <c-w>h
noremap  <C-l> <c-w>l
noremap  <C-j> <c-w>j
noremap  <C-k> <c-w>k

" faster movement
nnoremap <C-e> 7<C-e>
nnoremap <C-y> 7<C-y>

" Keep search pattern at the center of the screen.
nnoremap <silent> n     nzz
nnoremap <silent> j     gj
nnoremap <silent> k     gk
nnoremap <silent> N     Nzz
nnoremap <silent> *     *zz
nnoremap <silent> #     #zz
nnoremap <silent> g*    g*zz
nnoremap <silent> <Tab> %

" resource configuration
nnoremap <leader>sv :source $MYVIMRC<CR>

" remap U to <C-r> for easier redo
nnoremap U <C-r>
" move to line start/end
noremap  H ^
noremap  L $

" mark
nnoremap ' `
