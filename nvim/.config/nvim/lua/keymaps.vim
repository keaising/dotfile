" cSpell:disable
" Leader key
map <Space>         <Leader>

" save & quit in window
inoremap <m-s> <ESC>:wa<CR>
nnoremap <m-s> :wa<CR>
nnoremap <C-s> :w<CR>
nnoremap <m-q> :qa<CR>
nnoremap <C-q> :q<CR>
" save file with sudo
cnoremap sudow w !sudo tee % >/dev/null

" switch window
noremap  <C-h> <c-w>h
noremap  <C-l> <c-w>l
noremap  <C-j> <c-w>j
noremap  <C-k> <c-w>k

" split window
noremap <leader>vs :vsplit<CR>
noremap <leader>hs :split<CR>

" switch location
noremap <m-[>  <C-o>
noremap <m-]>  <C-i>

" faster movement
nnoremap <C-e> 9<C-e>
nnoremap <C-y> 9<C-y>

" move in insert mode
inoremap <m-h>  <left>
inoremap <m-j>  <down>
inoremap <m-k>  <up>
inoremap <m-l>  <right>
inoremap <m-b>  <C-o>b
inoremap <m-w>  <C-o>w
inoremap <m-e>  <C-o>e
inoremap <m-BS> <C-w>

" Keep search pattern at the center of the screen.
nnoremap <silent> n     nzzzv
nnoremap <silent> j     gj
nnoremap <silent> k     gk
nnoremap <silent> N     Nzzzv
nnoremap <silent> *     *zz
nnoremap <silent> #     #zz
nnoremap <silent> g*    g*zz
nnoremap <silent> <Tab> %
vnoremap <silent> <Tab> %

" come from https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/remap.lua
nnoremap <silent> J mzJ`z
vnoremap <silent> J :m '>+1<CR>gv=gv
vnoremap <silent> K :m '<-2<CR>gv=gv

" don't follow vim default behavior
xnoremap p P

nnoremap <leader>x :silent !chmod +x %<CR>

" select all
nnoremap ga ggVG

" move to line start/end
noremap H ^
noremap L $

" plus/minus
noremap = <C-a>
noremap - <C-x>

" run macro q/w
nnoremap <A-2> @q
nnoremap <A-3> @w

" mark
nnoremap ' `

" toggle current block, all level
nnoremap zo zA

" disable 
nnoremap <C-p> <nop>

" search selected content in visual mode: https://blog.twofei.com/610/
vnoremap // y/<c-r>"<cr>
nnoremap <leader>/ :noh<CR>

" insert mode specials
inoremap ;; :=

" resource configuration
nnoremap <leader>la :Lazy<CR>

" nnoremap <leader>sf :set filetype=
" nnoremap <leader>st :set syntax=

" buffer
nnoremap <silent> <m-h>      :BufferLineCyclePrev<CR>
nnoremap <silent> <m-l>      :BufferLineCycleNext<CR>
nnoremap <silent> <m-H>      :BufferLineMovePrev<CR>
nnoremap <silent> <m-L>      :BufferLineMoveNext<CR>
nnoremap <silent> <leader>wh :BufferLineCloseLeft<CR>
nnoremap <silent> <leader>wl :BufferLineCloseRight<CR>
nnoremap <silent> <leader>wa :BufferLineCloseOthers<CR>
nnoremap <silent> <m-e>      :BufferLinePick<CR>
nnoremap <silent> <m-w>      :Bdelete<CR>

" easy align
" | Keystrokes | Description                        | 等价的命令          | 描述                          |
" | ---------- | -----------                        | ------              | --                            |
" | 2<Space>   | Around 2nd whitespaces             | :'<,'>EasyAlign2\   | 第二个空格分隔                |
" | -<Space>   | Around the last whitespaces        | :'<,'>EasyAlign-\   | 最后一个空格分隔              |
" | -2<Space>  | Around the 2nd to last whitespaces | :'<,'>EasyAlign-2\  | 倒数第二个空格分隔            |
" | :          | Around 1st colon (key: value)      | :'<,'>EasyAlign:    | 第一个 : 分隔                 |
" | <Right>:   | Around 1st colon (key : value)     | :'<,'>EasyAlign:>l1 | 同上, 分隔符右对齐            |
" | =          | Around 1st operators with =        | :'<,'>EasyAlign=    | 第一个 = 分隔                 |
" | 3=         | Around 3rd operators with =        | :'<,'>EasyAlign3=   | 第三个 = 分隔                 |
" | *=         | Around all operators with =        | :'<,'>EasyAlign*=   | 所有的 = 分隔                 |
" | **=        | Left-right alternating around =    | :'<,'>EasyAlign**=  | = 先左->右对齐,然后交错对齐   |
" | <Enter>=   | Right alignment around 1st =       | :'<,'>EasyAlign!=   | 第一个 = 前的右对齐, 其他不变 |
" | <Enter>**= | Right-left alternating around =    | :'<,'>EasyAlign!**= | = 先右->左对齐,然后交错对齐   |
"
" tutorial: https://xu3352.github.io/linux/2018/10/18/vim-table-format-in-html-or-markdown
" cheat sheet: https://devhints.io/vim-easyalign
" Align by regex>    :EasyAlign /[:;]+/
" Start interactive EasyAlign in visual mode (e.g. vipga)
xnoremap ga <Plug>(EasyAlign)
" Align by regex
" :'<,'>EasyAlign /regex/
vnoremap gs :EasyAlign
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nnoremap ga <Plug>(EasyAlign)

" swap position for parameters
nnoremap <leader>, :SidewaysLeft<cr>
nnoremap <leader>. :SidewaysRight<cr>

" vim-move
let g:move_map_keys = 0
nnoremap <silent> <C-A-h> <Plug>MoveCharLeft
nnoremap <silent> <C-A-l> <Plug>MoveCharRight
nnoremap <silent> <C-A-j> <Plug>MoveLineDown
nnoremap <silent> <C-A-k> <Plug>MoveLineUp
vnoremap <silent> <C-A-h> <Plug>MoveBlockLeft
vnoremap <silent> <C-A-l> <Plug>MoveBlockRight
vnoremap <silent> <C-A-j> <Plug>MoveBlockDown
vnoremap <silent> <C-A-k> <Plug>MoveBlockUp

" vim maximizer
let g:maximizer_set_default_mapping = 0
nnoremap <silent><C-z> :MaximizerToggle<CR>
vnoremap <silent><C-z> :MaximizerToggle<CR>gv
inoremap <silent><C-z> <C-o>:MaximizerToggle<CR>

nnoremap <leader>cc <plug>NERDCommenterToggle
vnoremap <leader>cc <plug>NERDCommenterToggle
nnoremap <M-/>      <plug>NERDCommenterToggle
vnoremap <M-/>      <plug>NERDCommenterToggle

" lsp
nnoremap <leader>lr :LspStop<CR>:LspStart<CR>:LspRestart<CR>

" xnoremap i` <Plug>(textobj-backticks-backticks-ii)

" kylechui/nvim-surround
onoremap ir i[
onoremap ar a[
xnoremap ir i[
xnoremap ar a[

" AndrewRadev/sideways.vim
omap aa <Plug>SidewaysArgumentTextobjA
xmap aa <Plug>SidewaysArgumentTextobjA
omap ia <Plug>SidewaysArgumentTextobjI
xmap ia <Plug>SidewaysArgumentTextobjI
