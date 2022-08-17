-- The good old days in VIM

vim.cmd [[

" floaterm
    let g:floaterm_keymap_toggle = '<m-m>'
    let g:floaterm_width=0.85
    let g:floaterm_height=0.95

" format

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

let g:neoformat_enabled_json = ['jq']
let g:neoformat_enabled_lua = ['stylua']
let g:neoformat_enabled_python = ['black']
let g:neoformat_enabled_sh = ['shfmt']
let g:neoformat_enabled_zsh = ['shfmt']

let g:shfmt_opt="-ci"

let g:neoformat_try_formatprg = 1
let g:neoformat_only_msg_on_error = 1


" 'ruanyl/vim-gh-line' " invoke github/gitlab from vim
let g:gh_line_map_default = 0
let g:gh_line_blame_map_default = 1
let g:gh_line_map = '<leader>gh'
let g:gh_line_blame_map = '<leader>gb'
let g:gh_gitlab_domain = "git.curiostack.com"
let g:gh_use_canonical = 0

" text object
let g:vim_textobj_parameter_mapping = 'a'

" vim-sandwich
runtime macros/sandwich/keymap/surround.vim 

let g:UltiSnipsSnippetDirectories=[ "ultisnips" ]


" APZelos/blamer.nvim
let g:blamer_enabled = 1
let g:blamer_show_in_visual_modes = 0
let g:blamer_delay = 300
let g:blamer_prefix = '                                '
let g:blamer_template = '<committer>, <committer-time> • <summary>'
let g:blamer_date_format = '%y/%m/%d'
let g:blamer_relative_time = 1

let g:winresizer_start_key = '<C-T>'

let g:NERDDefaultAlign = 'left'
let g:NERDSpaceDelims = 1
let g:NERDAllowAnyVisualDelims = 0

]]
