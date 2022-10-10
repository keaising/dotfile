" Leader key
map      <Space>         <Leader>

" save & quit in window
inoremap <m-s> <ESC>:w<CR>
nnoremap <m-s> :w<CR>
nnoremap <m-w> :q<cr>
nnoremap <m-q> :qa<CR>
nnoremap <C-q> :q<CR>
" save file with sudo
cnoremap sudow w !sudo tee % >/dev/null

" resize window
nnoremap <silent> <m-Left>  :vertical resize +5<CR>
nnoremap <silent> <m-Right> :vertical resize -5<CR>
nnoremap <silent> <m-Up>    :resize   +5<CR>
nnoremap <silent> <m-Down>  :resize   -5<CR>

" switch window
noremap  <C-h> <c-w>h
noremap  <C-l> <c-w>l
noremap  <C-j> <c-w>j
noremap  <C-k> <c-w>k

" split window
noremap <C-\> :vsplit<CR>
noremap <C--> :split<CR>

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
" zg: add word to spell ignorance file
nnoremap <silent> zs :silent !sort ~/.config/nvim/spell/en.utf-8.add > /tmp/en.utf-8.add && cat /tmp/en.utf-8.add > ~/.config/nvim/spell/en.utf-8.add<CR>

" disable 
nnoremap <C-p> <nop>

" search selected content in visual mode: https://blog.twofei.com/610/
vnoremap // y/<c-r>"<cr>
nnoremap // :noh<CR>

" insert mode specials
inoremap ;; :=
" nnoremap <leader>p :let @+ = expand("%:p")<cr>

" resource configuration
nnoremap <leader>sv :PackerSync<CR>
nnoremap <leader>sc :PlugUpdate<CR>

nnoremap <leader>sf :set filetype=
nnoremap <leader>st :set syntax=

" buffer
nnoremap <silent> <m-{>      :BufferLineCyclePrev<CR>
nnoremap <silent> <m-}>      :BufferLineCycleNext<CR>
nnoremap <silent> <m-<>      :BufferLineMovePrev<CR>
nnoremap <silent> <m->>      :BufferLineMoveNext<CR>
nnoremap <silent> <leader>wh :BufferLineCloseLeft<CR>
nnoremap <silent> <leader>wl :BufferLineCloseRight<CR>
nnoremap <silent> <leader>wa :BufferLineCloseLeft<CR>
nnoremap <silent> <m-e>      :BufferLinePick<CR>
nnoremap <silent> <A-w>      :Bdelete<CR>

" telescope
nnoremap <leader>ss :Telescope find_files<CR>
nnoremap <leader>ff :Telescope live_grep<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fh :Telescope help_tags<CR>
nnoremap <leader>ft :Telescope<CR>

" format
nnoremap <leader>ft :Neoformat<CR>
nnoremap <leader>ft :Neoformat<CR>


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
nnoremap ga <Plug>(EasyAlign)

" ALT_+/- 用于按分隔符扩大缩小 v 选区, terryma/vim-expand-region
vnoremap v     <Plug>(expand_region_expand)
vnoremap <C-v> <Plug>(expand_region_shrink)

" hop
nnoremap s :HopChar2<CR>

nnoremap <leader>cc <plug>NERDCommenterToggle
vnoremap <leader>cc <plug>NERDCommenterToggle
nnoremap <M-/>      <plug>NERDCommenterToggle
vnoremap <M-/>      <plug>NERDCommenterToggle

" lsp
nnoremap <leader>lr :LspRestart<CR>

" go
nnoremap gj         :GoAddTags json<CR>
nnoremap gmt        :GoModTidy<CR>
nnoremap <leader>gt :GoAddTest<CR>

