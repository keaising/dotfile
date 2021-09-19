"----------------------------------------------------------------------
" 默认情况下的分组，可以再前面覆盖之
"----------------------------------------------------------------------
if !exists('g:bundle_group')
	let g:bundle_group =  ['default', 'basic', 'enhanced', 'textobj', 'filetypes']
	let g:bundle_group += ['colorscheme', 'interface']
	let g:bundle_group += ['nerdtree', 'language']
	let g:bundle_group += ['nvim']
endif


"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc


"----------------------------------------------------------------------
" 计算当前 vim-init 的子路径
"----------------------------------------------------------------------
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')

function! s:path(path)
	let path = expand(s:home . '/' . a:path )
	return substitute(path, '\\', '/', 'g')
endfunc

"----------------------------------------------------------------------
" install plug
"----------------------------------------------------------------------
" call plug#begin(get(g:, 'bundle_home', '~/.vim/bundles'))
call plug#begin()


"----------------------------------------------------------------------
" 默认插件 
"----------------------------------------------------------------------

if index(g:bundle_group, 'default') >= 0
" Diff 增强，支持 histogram / patience 等更科学的 diff 算法
Plug 'chrisbra/vim-diff-enhanced'
" enable the patience diff algorithm when starting as vimdiff / git difftool /
if &diff
	let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

" There is a bug in easymotion, waiting for fixing.
" https://github.com/easymotion/vim-easymotion/issues/402
" 全文快速移动，<leader><leader>f{char} 即可触发
Plug 'easymotion/vim-easymotion'
map  <Leader>w <Plug>(easymotion-bd-w)
nmap s         <Plug>(easymotion-s2)
" <Leader>f{char} to move to {char}
" map  <Leader>f <Plug>(easymotion-bd-f)
" Move to line
" map  <Leader>l <Plug>(easymotion-bd-jk)
" Move to word
" map  /         <Plug>(easymotion-sn)
" omap /         <Plug>(easymotion-tn)
" These `n` & `N` mappings are options. You do not have to map `n` & `N` to EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" different highlight method and have some other features )
" map  n         <Plug>(easymotion-next)
" map  N         <Plug>(easymotion-prev)

endif


"----------------------------------------------------------------------
" 基础插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'basic') >= 0

	" 支持库，给其他插件用的函数库
	Plug 'xolox/vim-misc'

	" 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
	Plug 'kshenoy/vim-signature'

	" 根据 quickfix 中匹配到的错误信息，高亮对应文件的错误行
	" 使用 :RemoveErrorMarkers 命令或者 <space>ha 清除错误
	" Plug 'mh21/errormarker.vim'

	" 使用 ALT+e 会在不同窗口/标签上显示 A/B/C 等编号，然后字母直接跳转
	Plug 't9md/vim-choosewin'

	" Git 支持
	Plug 'tpope/vim-fugitive'

	" 使用 ALT+E 来选择窗口
	nmap <m-e> <Plug>(choosewin)
	nmap -     <Plug>(choosewin)

	" 使用 <space>ha 清除 errormarker 标注的错误
	nnoremap <silent><leader>ha :RemoveErrorMarkers<cr>
endif


"----------------------------------------------------------------------
" 增强插件
"----------------------------------------------------------------------
if index(g:bundle_group, 'enhanced') >= 0

	" automate actions
	Plug 'tpope/vim-repeat'
	Plug 'tpope/vim-surround'
	Plug 'tpope/vim-abolish'

	Plug 'wesQ3/vim-windowswap'

	" 自动更新 tab name
	Plug 'gcmt/taboo.vim'
	let g:taboo_tab_format="%N %f%m"

	" 用 v 选中一个区域后，ALT_+/- 按分隔符扩大/缩小选区
	Plug 'terryma/vim-expand-region'

	" 给不同语言提供字典补全，插入模式下 c-x c-k 触发
	Plug 'asins/vim-dict'

	" 使用 :CtrlSF 命令进行模仿 sublime 的 grep
	" Plug 'dyng/ctrlsf.vim'

	" 配对括号和引号自动补全
	Plug 'Raimondi/delimitMate'

	" ALT_+/- 用于按分隔符扩大缩小 v 选区
	map  <m-=> <Plug>(expand_region_expand)
	map  <m--> <Plug>(expand_region_shrink)
	vmap v     <Plug>(expand_region_expand)
	vmap <C-v> <Plug>(expand_region_shrink)

	" add / delete comment
	Plug 'preservim/nerdcommenter'
	let g:NERDSpaceDelims = 1

	" 表格对齐，使用命令 Tabularize
	Plug 'godlygeek/tabular', { 'on': 'Tabularize' }

	" align
	Plug 'junegunn/vim-easy-align'
	" tutorial: https://xu3352.github.io/linux/2018/10/18/vim-table-format-in-html-or-markdown
	" Start interactive EasyAlign in visual mode (e.g. vipga)
	xmap ga <Plug>(EasyAlign)
	" Start interactive EasyAlign for a motion/text object (e.g. gaip)
	nmap ga <Plug>(EasyAlign)

	" terminal
	" Plug 'skywind3000/vim-terminal-help'
	" let g:terminal_height = 15

	" function SetTerminalHeight(height) 
		" let g:terminal_height = a:height
	" endfunction
	" nnoremap <A-C-h> :call SetTerminalHeight(

	Plug 'ruanyl/vim-gh-line'
	let g:gh_line_map_default = 0
	let g:gh_line_blame_map_default = 1
	let g:gh_line_map = '<leader>gh'
	let g:gh_line_blame_map = '<leader>gb'
	let g:gh_gitlab_domain = "git.curiostack.com"

endif


"----------------------------------------------------------------------
" 文本对象：textobj 全家桶
"----------------------------------------------------------------------
if index(g:bundle_group, 'textobj') >= 0

	" 基础插件：提供让用户方便的自定义文本对象的接口
	Plug 'kana/vim-textobj-user'

	" indent 文本对象：ii/ai 表示当前缩进，vii 选中当缩进，cii 改写缩进
	Plug 'kana/vim-textobj-indent'

	" 语法文本对象：iy/ay 基于语法的文本对象
	Plug 'kana/vim-textobj-syntax'

	" 函数文本对象：if/af 支持 c/c++/vim/java
	Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java', 'javascript', 'go', 'python', 'typescript'] }

	" 参数文本对象：i,/a, 包括参数或者列表元素
	Plug 'sgur/vim-textobj-parameter'
	let g:vim_textobj_parameter_mapping = 'a'

	" 提供 uri/url 的文本对象，iu/au 表示
	Plug 'jceb/vim-textobj-uri'
endif



"----------------------------------------------------------------------
" 文件类型扩展
"----------------------------------------------------------------------
if index(g:bundle_group, 'filetypes') >= 0

	" powershell 脚本文件的语法高亮
	Plug 'pprovost/vim-ps1', { 'for': 'ps1' }

	" lua 语法高亮增强
	Plug 'tbastos/vim-lua', { 'for': 'lua' }

	" C++ 语法高亮增强，支持 11/14/17 标准
	Plug 'octol/vim-cpp-enhanced-highlight', { 'for': ['c', 'cpp'] }

	" 额外语法文件
	Plug 'justinmk/vim-syntax-extra', { 'for': ['c', 'bison', 'flex', 'cpp'] }

	" python 语法文件增强
	Plug 'vim-python/python-syntax', { 'for': ['python'] }

	" rust 语法增强
	Plug 'rust-lang/rust.vim', { 'for': 'rust' }

	" vim org-mode 
	Plug 'jceb/vim-orgmode', { 'for': 'org' }
endif


"----------------------------------------------------------------------
" Colorfull
"----------------------------------------------------------------------
" colorscheme 
if index(g:bundle_group, 'colorscheme') >= 0
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
	" let g:airline_theme = 'gruvbox_material'

	" tab 
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#show_buffers = 0
	let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
	let g:airline#extensions#tabline#show_tab_nr = 0
	let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

	" enable/disable displaying buffers with a single tab. (c) >
	let g:airline#extensions#tabline#show_buffers = 1
	let g:airline#extensions#tabline#show_tab_type = 1
	let g:airline#extensions#tabline#buffers_label = 'b'
	let g:airline#extensions#tabline#tabs_label = 't'

	let g:airline#extensions#branch#enabled = 1
	let g:airline#extensions#syntastic#enabled = 0
	let g:airline#extensions#fugitiveline#enabled = 0
	let g:airline#extensions#csv#enabled = 1
	let g:airline#extensions#vimagit#enabled = 0

	Plug 'ryanoasis/vim-devicons'
endif



"----------------------------------------------------------------------
" Interface
"----------------------------------------------------------------------
if index(g:bundle_group, 'interface') >= 0
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
	
	" git blame info
	Plug 'zivyangll/git-blame.vim'
	nnoremap <Leader>b :<C-u>call gitblame#echo()<CR>
	
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

	tnoremap <m-p> <C-\><C-n>:FloatermPrev<CR>
	tnoremap <m-n> <C-\><C-n>:FloatermNext<CR>
	" Can't use <C-i>, https://unix.stackexchange.com/questions/563469/conflict-ctrl-i-with-tab-in-normal-mode/563480#563480
	let g:floaterm_keymap_toggle = '<m-m>'
	let g:floaterm_width=0.85
	let g:floaterm_height=0.95

endif
 

"----------------------------------------------------------------------
" NERDTree
"----------------------------------------------------------------------
if index(g:bundle_group, 'nerdtree') >= 0
	" Plug 'scrooloose/nerdtree', {'on': ['NERDTree', 'NERDTreeFocus', 'NERDTreeToggle', 'NERDTreeCWD', 'NERDTreeFind'] }
	Plug 'preservim/nerdtree'
	" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
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
	" key bindings
	" nnoremap <leader>n   :NERDTreeFocus<CR>
	nnoremap <C-n>       :NERDTreeToggle<CR><C-w>w
	" nnoremap <C-f> :NERDTreeFind<CR>
endif



"----------------------------------------------------------------------
" Language
"----------------------------------------------------------------------
if index(g:bundle_group, 'language') >= 0
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
	Plug 'buoto/gotests-vim'
	" :GoTests/:GoTestsAll
	
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	let g:coc_global_extensions = [ 
		\ 'coc-git', 
		\ 'coc-go', 
		\ 'coc-sources', 
		\ 'coc-rls', 
		\ 'coc-dictionary', 
		\ 'coc-emoji', 
		\'coc-tssever' ]

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
endif

"----------------------------------------------------------------------
" NeoVIM only plugins
"----------------------------------------------------------------------

if has("nvim") && (index(g:bundle_group, 'nvim') >= 0)
	" best terminal in nvim ever
	" Plug 'numtostr/FTerm.nvim'

	" some foundamental plugin
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'kyazdani42/nvim-web-devicons'
	Plug 'folke/lsp-colors.nvim'

	Plug 'glepnir/smartinput.nvim'

	" more accurate highlight
	" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

	" Plug 'neovim/nvim-lspconfig'

	" diffview
	" Plug 'sindrets/diffview.nvim'
	" nnoremap <m-n> :DiffviewOpen<CR><C-n>

	" ----------- show all problems ----------- 
	" Plug 'folke/trouble.nvim'
	" nnoremap <leader>xt <cmd>TroubleToggle<cr>
	" nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
	" nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
	" nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
	" nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
	" nnoremap <leader>xr <cmd>TroubleToggle lsp_references<cr>
	" autocmd WinEnter * if winnr('$') == 1 && &ft == 'LspTrouble' | q | endif

	" ========================================================== 
	" Git blame
	" ========================================================== 
	" Plug 'lewis6991/gitsigns.nvim'
	" Plug 'keaising/nvim-blame-line'
	" let g:blameLineMessageWhenNotYetCommited = ' '
	" nnoremap <silent> <leader>bl :ToggleBlameLine<CR>
	" 不能打开默认页面，会导致每行 git blame 信息都打开一个tab
	" autocmd BufEnter * EnableBlameLine
endif




"----------------------------------------------------------------------
" Nvim Tree
"----------------------------------------------------------------------
" for file icons
" Plug 'kyazdani42/nvim-web-devicons' 
" Plug 'kyazdani42/nvim-tree.lua'

" nnoremap <C-n> :NvimTreeToggle<CR>
" nnoremap <leader>r :NvimTreeRefresh<CR>
" nnoremap <leader>n :NvimTreeFindFile<CR>

" let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ]
" let g:nvim_tree_auto_open = 0
" let g:nvim_tree_auto_close = 1
" let g:nvim_tree_tab_open = 0

 " autocmd BufEnter * if winnr('$') == 1 && exists('b:NvimTree') |
		     "    \ quit | endif



" "----------------------------------------------------------------------
" " nertw
" "----------------------------------------------------------------------
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 20
" augroup ProjectDrawer
  " autocmd!
  " autocmd VimEnter * :Vexplore
" augroup END



"----------------------------------------------------------------------
" LSP
"----------------------------------------------------------------------
" Plug 'prabirshrestha/vim-lsp'
" Plug 'prabirshrestha/vim-lsp'
" Plug 'mattn/vim-lsp-settings'

" function! s:on_lsp_buffer_enabled() abort
    " setlocal omnifunc=lsp#complete
    " setlocal signcolumn=yes
    " if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif

    " nmap     <buffer> <A-b>       <plug>(lsp-definition)
    " nmap     <buffer> gs          <plug>(lsp-document-symbol-search)
    " nmap     <buffer> gS          <plug>(lsp-workspace-symbol-search)
    " nmap     <buffer> gr          <plug>(lsp-references)
    " nmap     <buffer> gi          <plug>(lsp-implementation)
    " nmap     <buffer> gt          <plug>(lsp-type-definition)
    " nmap     <buffer> <A-k>       <plug>(lsp-rename)
    " nmap     <buffer> [g          <plug>(lsp-previous-diagnostic)
    " nmap     <buffer> ]g          <plug>(lsp-next-diagnostic)
    " nmap     <buffer> K           <plug>(lsp-hover)
    " inoremap <buffer> <expr><c-f> lsp#scroll(+4)
    " inoremap <buffer> <expr><c-d> lsp#scroll(-4)

    " let g:lsp_format_sync_timeout = 1000
    " autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
    
    " " refer to doc to add more commands
" endfunction

" augroup lsp_install
    " au!
    " " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    " autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END


" " auto complete
" Plug 'prabirshrestha/asyncomplete.vim'
" Plug 'prabirshrestha/asyncomplete-lsp.vim'

" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" " allow modifying the completeopt variable, or it will
" " be overridden all the time
" let g:asyncomplete_auto_completeopt = 0
" set completeopt=menuone,noinsert,preview
" autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif



call plug#end()

