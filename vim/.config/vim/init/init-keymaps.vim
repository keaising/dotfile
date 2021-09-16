" Leader key
map      <Space>         <Leader>

" save & quit in window
inoremap <m-s>   <ESC>:w<CR>
nnoremap <m-s>   :w<CR>
nnoremap <m-w>   :q<cr>

" resize window
nnoremap <m-=>     :vertical resize +5<CR>
nnoremap <m-->     :vertical resize -5<CR>
nnoremap <m-Left>  :vertical resize +5<CR>
nnoremap <m-Right> :vertical resize -5<CR>
nnoremap <m-Up>    :resize   +5<CR>
nnoremap <m-Down>  :resize   -5<CR>

" switch tabs
" nnoremap <leader>[ :tabprevious<CR>
" nnoremap <leader>] :tabnext<CR>
nnoremap <m-{> :tabprevious<CR>
nnoremap <m-}> :tabnext<CR>
nnoremap <m-l> :tabprevious<CR>
nnoremap <m-h> :tabnext<CR>
" delete buffer
" nnoremap <m-d> :bd<CR>

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
nnoremap <C-e> 8<C-e>
nnoremap <C-y> 8<C-y>

" move in insert mode
" Ctrl - comflict with coc-snippets
" inoremap <C-h> <left>
" inoremap <C-j> <down>
" inoremap <C-k> <up>
" inoremap <C-l> <right>
" inoremap <C-b> <C-o>b
" inoremap <C-w> <C-o>w
" inoremap <C-e> <C-o>e
" Alt 
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

" resource configuration
nnoremap <leader>sv :source $MYVIMRC<CR>

" remap U to <C-r> for easier redo
nnoremap U <C-r>

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

" save file with sudo
cnoremap sudow w !sudo tee % >/dev/null


" Tabularize
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

" insert mode specials
inoremap ;; :=
nnoremap <leader>p :let @+ = expand("%:p")<cr>
