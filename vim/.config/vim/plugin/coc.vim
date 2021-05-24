" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-go']

autocmd User CocLocationsChange CocList --normal location

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

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
