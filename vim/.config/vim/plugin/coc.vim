" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
let g:coc_global_extensions = [
	\ 'coc-json',
	\ 'coc-prettier',
	\ 'coc-git',
	\ 'coc-go',
	\ 'coc-tsserver',
	\ 'coc-snippets',
	\ 'coc-dictionary',
	\ 'coc-word',
	\ 'coc-emoji' ]

command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

" ----------------------------------------------------
"  completion
" ----------------------------------------------------
nmap     <silent>[g <Plug>(coc-diagnostic-prev)
nmap     <silent>]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap     <silent><m-b>      :<C-u>call CocActionAsync('jumpDefinition')<CR>zz
" nmap     <silent><m-k>      <Plug>(coc-rename)
nmap     <silent>gi         <Plug>(coc-implementation)
nmap     <silent>gr         <Plug>(coc-references)
nmap     <silent><leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap     <silent><leader>f  <Plug>(coc-format-selected)
nmap     <silent><leader>f  <Plug>(coc-format-selected)
nnoremap <silent><leader>l  :CocList --normal --first diagnostics<cr>

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-@> coc#refresh()
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

autocmd User CocLocationsChange CocList --normal location
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')



" ----------------------------------------------------
"  snippet
" ----------------------------------------------------
" Use <C-l> for trigger snippet expand.
" imap <C-l> <Plug>(coc-snippets-expand)
" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)
" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'
" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

