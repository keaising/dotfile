nnoremap <leader>gg :call GormModify()<CR>
vnoremap <leader>gg :call GormModify()<CR>

function! GormModify() range
  execute a:firstline . "," . a:lastline . 'GoRemoveTags bson es2m'
  execute a:firstline . "," . a:lastline . 'GoAddTags gorm'
  silent! execute a:firstline . "," . a:lastline . 's/gorm:"\(.*\)"/gorm:"column:\1;type:text"/g'
endfunction
