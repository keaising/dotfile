" cSpell:disable

" let g:sonokai_style = 'shusia'
" colorscheme sonokai
" colorscheme gruvbox-material
" let g:gruvbox_contrast_dark = 'soft'
" set bg=light
" colorscheme gruvbox
let g:gruvbox_material_current_word = "underline"
colorscheme gruvbox-material
" colorscheme kanagawa-lotus
colorscheme dayfox

set termguicolors
set t_Co=256             " 允许256色
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

highlight IndentBlanklineIndent1 guifg=#E06C75 gui=nocombine
highlight IndentBlanklineIndent2 guifg=#E5C07B gui=nocombine
highlight IndentBlanklineIndent3 guifg=#98C379 gui=nocombine
highlight IndentBlanklineIndent4 guifg=#56B6C2 gui=nocombine
highlight IndentBlanklineIndent5 guifg=#61AFEF gui=nocombine
highlight IndentBlanklineIndent6 guifg=#C678DD gui=nocombine
