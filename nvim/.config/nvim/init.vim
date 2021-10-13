
" basic -----{{{

set autoindent
set tabstop=4                     "按下 Tab 键时，Vim 显示的空格数
set shiftwidth=4
set softtabstop=0                 "关闭softtabstop 永远不要将空格和tab混合输入
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
set ttimeoutlen=50
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
set backupdir=~/.vim/tmp          " 备份文件地址，统一管理
set backupext=.bak                " 备份文件扩展名
set noswapfile                    " 禁用交换文件
set noundofile                    " 禁用 undo文件
set scrolloff=5                   "垂直滚动时，光标距离顶部/底部的位置（单位：行）
set sidescrolloff=15              "水平滚动时，光标距离行首或行尾的位置（单位：字符）。该配置在不折行时比较有用

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



" file_type -----{{{ 

augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    " edit vimrc
    :nnoremap <leader>ev :vsplit $MYVIMRC<cr>
    :nnoremap <leader>sv :source $MYVIMRC<cr>
    autocmd FileType vim :iabbrev <buffer> --- -----{{{
augroup END
" }}} 

augroup filetype_terminal
    autocmd!
    autocmd FileType zsh  setlocal foldmethod=marker
    autocmd FileType tmux setlocal foldmethod=marker
augroup END

augroup filetype_golang
	autocmd!
	au FileType go     setlocal tabstop=8 shiftwidth=8
augroup END

" }}}



" key_map -----{{{ 

" Leader key
map      <Space>         <Leader>

" save & quit in window
inoremap <m-s>   <ESC>:w<CR>
nnoremap <m-s>   :w<CR>
nnoremap <m-w>   :q<cr>

" resize window
nnoremap <m-Left>  :vertical resize +5<CR>
nnoremap <m-Right> :vertical resize -5<CR>
nnoremap <m-Up>    :resize   +5<CR>
nnoremap <m-Down>  :resize   -5<CR>

" switch tabs
nnoremap <m-{> :tabprevious<CR>
nnoremap <m-}> :tabnext<CR>
nnoremap <m-l> :tabnext<CR>
nnoremap <m-h> :tabprevious<CR>

" switch window
noremap  <C-h> <c-w>h
noremap  <C-l> <c-w>l
noremap  <C-j> <c-w>j
noremap  <C-k> <c-w>k

" switch location
noremap <m-[>  <C-o>
noremap <m-]>  <C-i>
" for ssh to clinkz
noremap <ESC>[ <C-o>
noremap <ESC>] <C-i>

" faster movement
nnoremap <C-e> 9<C-e>
nnoremap <C-y> 9<C-y>

" move in insert mode
inoremap <m-h> <left>
inoremap <m-j> <down>
inoremap <m-k> <up>
inoremap <m-l> <right>
inoremap <m-b> <C-o>b
inoremap <m-w> <C-o>w
inoremap <m-e> <C-o>e

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

" close all recursively
nmap zm zM
" open current recursively
nmap zo zO
" open all recursively
nmap zr zR
" close current: zc
" open/close current: za

" disable 
nnoremap <C-p> <nop>

" search selected content in visual mode: https://blog.twofei.com/610/
vnoremap // y/<c-r>"<cr>
nnoremap // :noh<CR>

" insert mode specials
inoremap ;; :=
" nnoremap <leader>p :let @+ = expand("%:p")<cr>

" resource configuration
nnoremap <leader>sv :source $MYVIMRC<CR>

nnoremap <leader>sf :set filetype=

" save file with sudo
cnoremap sudow w !sudo tee % >/dev/null

" }}}



" config -----{{{

" 终端下允许 ALT
if has('nvim') == 0 && has('gui_running') == 0
	function! s:metacode(key)
		exec "set <M-".a:key.">=\e".a:key
	endfunc
	for i in range(10)
		call s:metacode(nr2char(char2nr('0') + i))
	endfor
	for i in range(26)
		call s:metacode(nr2char(char2nr('a') + i))
		call s:metacode(nr2char(char2nr('A') + i))
	endfor
	for c in [',', '.', '/', ';', '[', ']', '{', '}']
		call s:metacode(c)
	endfor
	for c in ['?', ':', '-', '_', '+', '=', "'"]
		call s:metacode(c)
	endfor
endif

" 打开文件时恢复上一次光标所在位置
autocmd BufReadPost *
	\ if line("'\"") > 1 && line("'\"") <= line("$") |
	\	 exe "normal! g`\"" |
	\ endif

" }}}



" plugin -----{{{

call plug#begin()

" There is a bug in easymotion, waiting for fixing.
" https://github.com/easymotion/vim-easymotion/issues/402
" 全文快速移动，<leader><leader>f{char} 即可触发
Plug 'easymotion/vim-easymotion'
map  <Leader>w <Plug>(easymotion-bd-w)
nmap s         <Plug>(easymotion-s2)

" 支持库，给其他插件用的函数库
Plug 'xolox/vim-misc'

" 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
Plug 'kshenoy/vim-signature'

" 使用 - 会在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
Plug 't9md/vim-choosewin'
nmap -     <Plug>(choosewin)

Plug 'tpope/vim-repeat'     " advanced repeat
Plug 'tpope/vim-surround'   " surround
Plug 'tpope/vim-abolish'    " crs/crm/crc
Plug 'wesQ3/vim-windowswap'
Plug 'Raimondi/delimitMate' " 配对括号和引号自动补全

Plug 'terryma/vim-expand-region' " 用 v 选中一个区域后，ALT_+/- 按分隔符扩大/缩小选区
" ALT_+/- 用于按分隔符扩大缩小 v 选区
vmap v     <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

Plug 'preservim/nerdcommenter'
let g:NERDSpaceDelims = 1

" 表格对齐，使用命令 Tabularize
Plug 'godlygeek/tabular', { 'on': 'Tabularize' }
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
function! s:align()
	let p = '^\s*|\s.*\s|\s*$'
	if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
		let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
		let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
		Tabularize/|/l1
		normal! 0
		call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
	endif
endfunction

" align
Plug 'junegunn/vim-easy-align'
" tutorial: https://xu3352.github.io/linux/2018/10/18/vim-table-format-in-html-or-markdown
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

Plug 'ruanyl/vim-gh-line' " invoke github/gitlab from vim
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 1
let g:gh_line_map = '<leader>gh'
let g:gh_line_blame_map = '<leader>gb'
let g:gh_gitlab_domain = "git.curiostack.com"
Plug 'zivyangll/git-blame.vim' " git blame info
nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>

Plug 'kana/vim-textobj-user' " 基础插件：提供让用户方便的自定义文本对象的接口
Plug 'kana/vim-textobj-indent' " indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
Plug 'kana/vim-textobj-syntax' " 语法文本对象：iy/ay 基于语法的文本对象
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java', 'javascript', 'go', 'python', 'typescript'] } " 函数文本对象：if/af 支持 c/c++/vim/java
let g:vim_textobj_parameter_mapping = 'a'
Plug 'sgur/vim-textobj-parameter' " 参数文本对象：i,/a, 包括参数或者列表元素
Plug 'jceb/vim-textobj-uri' " 提供 uri/url 的文本对象，iu/au 表示

Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'rafi/awesome-vim-colorschemes'
Plug 'sainnhe/everforest'
Plug 'sainnhe/edge'
Plug 'sainnhe/gruvbox-material'
Plug 'ErichDonGubler/vim-sublime-monokai'
Plug 'rhysd/vim-color-spring-night'
Plug 'junegunn/seoul256.vim'
Plug 'arzg/vim-colors-xcode'
Plug 'morhetz/gruvbox'
Plug 'liuchengxu/space-vim-theme'
Plug 'sainnhe/gruvbox-material'
Plug 'ryanoasis/vim-devicons'

" airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_powerline_fonts = 0
let g:airline_exclude_preview = 1
let g:airline_section_b = '%n'
let g:airline_theme='deus'
" tab 
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#buffers_label = 'b'
let g:airline#extensions#tabline#tabs_label = 't'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#syntastic#enabled = 0
let g:airline#extensions#fugitiveline#enabled = 0
let g:airline#extensions#csv#enabled = 1
let g:airline#extensions#vimagit#enabled = 0

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" --no-ignore
let $FZF_DEFAULT_COMMAND='rg --hidden --files -g !.git'
nnoremap <leader>ss :Files<CR>
nnoremap <leader>ff :Rg<CR> 
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden -g !.git  --sort path --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview('up', 'ctrl-/'), <bang>0)
" It's a problem of nvim for fzf-vim will be very slow in startup, workround at: https://github.com/neovim/neovim/issues/8939#issuecomment-417797284
let g:projectionist_ignore_man=1
let g:fzf_action = {
  \ 'enter':  'tab split',
  \ 'ctrl-o': 'e', 
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

Plug 'voldikss/vim-floaterm'
nnoremap <leader>lf :FloatermNew lf<cr>
nnoremap <leader>ln :FloatermNew<CR>
nnoremap <leader>lk :FloatermKill<cr>
tnoremap <m-p>      <C-\><C-n>:FloatermPrev<CR>
tnoremap <m-n>      <C-\><C-n>:FloatermNext<CR>
" Can't use <C-i>, https://unix.stackexchange.com/questions/563469/conflict-ctrl-i-with-tab-in-normal-mode/563480#563480
let g:floaterm_keymap_toggle = '<m-m>'
let g:floaterm_width=0.85
let g:floaterm_height=0.95

Plug 'preservim/nerdtree'
let g:NERDTreeMinimalUI    = 1
let g:NERDTreeDirArrows    = 1
let g:NERDTreeMapOpenInTab = '<ENTER>'
let g:NERDTreeShowHidden   = 1
let NERDTreeIgnore=['\.git$', '\.idea$', '\.vscode$', '\.history$']
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
			\ quit | endif
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
			\ quit | endif
" Open the existing NERDTree on each new tab.
autocmd  BufWinEnter * silent NERDTreeMirror
nnoremap <C-n>       :NERDTreeToggle<CR><C-w>w

Plug 'fatih/vim-go' ", { 'do': ':GoUpdateBinaries' }
let g:go_auto_sameids = 0
" let g:go_updatetime = 800
let g:go_highlight_functions = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_variable_declarations = 1
let g:go_highlight_variable_assignments = 1
Plug 'buoto/gotests-vim'  " :GoTests/:GoTestsAll
nnoremap <leader>ggt :GoTests<CR>


Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = [
	\ 'coc-json',
	\ 'coc-prettier',
	\ 'coc-spell-checker',
	\ 'coc-git',
	\ 'coc-go',
	\ 'coc-java',
	\ 'coc-tsserver',
	\ 'coc-snippets',
	\ 'coc-dictionary',
	\ 'coc-word',
	\ 'coc-sql',
	\ 'coc-emoji' ]

nmap [[         <Plug>(coc-diagnostic-prev)
nmap ]]         <Plug>(coc-diagnostic-next)
nmap <m-k>      <Plug>(coc-rename)
nmap gi         <Plug>(coc-implementation)
nmap gr         <Plug>(coc-references)
nmap <m-r>      <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <m-k>      <Plug>(coc-rename)
vmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap gn         <Plug>(coc-diagnostic-prev)
nmap gp         <Plug>(coc-diagnostic-next)

nmap     <silent><m-b>      :<C-u>call CocActionAsync('jumpDefinition')<CR>zz
nnoremap <silent><leader>l  :CocList --normal diagnostics<cr>
" Alt+j/k to go to next/previous selection
inoremap <expr> <m-j> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <m-k> pumvisible() ? "\<C-p>" : "\<S-Tab>"

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

autocmd User CocLocationsChange CocList --normal location
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
" let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
" let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_next = '<tab>'

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" format tools
Plug 'sbdchd/neoformat'
nnoremap <leader>ft  :Neoformat<CR>
vnoremap <leader>ft  :Neoformat<CR>
let g:neoformat_json_jq = {
        \ 'exe': 'jq',
        \ 'args': ['--indent 4'],
        \ 'stdin': 1, 
        \ 'env': ["DEBUG=1"], 
        \ 'valid_exit_codes': [0, 23],
        \ 'no_append': 1,
        \ }
let g:neoformat_enabled_json = ['jq']
let g:neoformat_pg_sql_pg_format = {
        \ 'exe': 'pg_format',
        \ 'args': ['--keyword-case 2 --wrap-limit 80'],
        \ 'stdin': 1, 
        \ 'env': ["DEBUG=1"], 
        \ 'valid_exit_codes': [0, 23],
        \ 'no_append': 1,
        \ }
let g:neoformat_enabled_pg_sql = ['pg_format']
let g:neoformat_javascript_prettier = {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin-filepath', '"%:p"'],
        \ 'stdin': 1, 
        \ 'valid_exit_codes': [0, 23],
        \ 'no_append': 1,
        \ }
let g:neoformat_enabled_javascript = ['prettier']
let g:neoformat_typescript_prettier = {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin-filepath', '"%:p"'],
        \ 'stdin': 1, 
        \ 'valid_exit_codes': [0, 23],
        \ 'no_append': 1,
        \ }
let g:neoformat_enabled_typescript = ['prettier']
let g:neoformat_markdown_prettier = {
        \ 'exe': 'prettier',
        \ 'args': ['--stdin-filepath', '"%:p"'],
        \ 'stdin': 1, 
        \ 'valid_exit_codes': [0, 23],
        \ 'no_append': 1,
        \ }
let g:neoformat_enabled_markdown = ['prettier']
let g:neoformat_try_formatprg = 1
let g:neoformat_only_msg_on_error = 1


call plug#end()

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

" color dracula
" colorscheme one
" colorscheme dracula
colorscheme gruvbox-material

" }}}



" lua -----{{{

lua require("init")

" }}}
