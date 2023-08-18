" go
nnoremap <leader>gj :GoAddTags json
" nnoremap <leader>gt :GoTests<CR>
nnoremap <silent> <leader>gl :silent !golines -w %:p<CR>

nnoremap <leader>gg :call GormModify()<CR>
vnoremap <leader>gg :call GormModify()<CR>

function! GormModify() range
  execute a:firstline . "," . a:lastline . 'GoRemoveTags bson es2m'
  execute a:firstline . "," . a:lastline . 'GoAddTags json gorm db'
  silent! execute a:firstline . "," . a:lastline . 's/gorm:"\(.\{-}\)"/gorm:"column:\1;type:text"/g'
endfunction

nnoremap <silent> <leader>vv v<Plug>(textobj-backtick-i) :!pg_format<CR>
