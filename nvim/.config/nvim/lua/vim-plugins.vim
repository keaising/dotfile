" cSpell:disable
" The good old days in VIM

" floaterm
let g:floaterm_keymap_toggle = '<m-m>'
let g:floaterm_width=0.85
let g:floaterm_height=0.95

" 'ruanyl/vim-gh-line' " invoke github/gitlab from vim
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 1
let g:gh_line_map = '<leader>gh'
let g:gh_line_blame_map = '<leader>gb'
let g:gh_gitlab_domain = "git.curiostack.com"
let g:gh_use_canonical = 0

" text object
let g:vim_textobj_parameter_mapping = 'a'

let g:UltiSnipsSnippetDirectories=[ "ultisnips" ]

"let g:winresizer_start_key = '<C-T>'

let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDAllowAnyVisualDelims = 0
let g:NERDCreateDefaultMappings = 0

" vim-repeat
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)


" vim-go
let g:go_auto_sameids = 0
let g:go_fmt_autosave = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_imports_mode = 'gopls'
let g:go_gopls_gofumpt = v:true
let g:go_def_mapping_enabled = 0
let g:go_snippet_engine = ""
" highlight
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
" msg
let g:go_echo_command_info = 0


" osc52 yank
autocmd TextYankPost *
  \  if ( v:event.operator is 'y' || v:event.operator is 'c' || v:event.operator is 'd' )
  \      && v:event.regname is '' |
  \    execute 'OSCYankReg "' |
  \  endif
" autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '+' | execute 'OSCYankReg +' | endif
let g:oscyank_max_length = 100000000
let g:oscyank_silent = v:true


" kshenoy/vim-signature
let g:SignatureMap = {
  \ 'GotoNextSpotAlpha'  :  "",
  \ 'GotoPrevSpotAlpha'  :  "",
  \ }

