-- floaterm
vim.cmd [[
    let g:floaterm_keymap_toggle = '<m-m>'
    let g:floaterm_width=0.85
    let g:floaterm_height=0.95
]]

-- format
vim.cmd [[ 
let g:neoformat_json_jq = {
        \ 'exe': 'jq',
        \ 'args': ['--indent 4'],
        \ 'stdin': 1, 
        \ 'env': ["DEBUG=1"], 
        \ 'valid_exit_codes': [0, 23],
        \ 'no_append': 1,
        \ }
let g:neoformat_enabled_json = ['jq']

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

let g:neoformat_lua_stylua = {
		\ 'exe': 'stylua',
		\ 'args': ['--search-parent-directories', '--stdin-filepath', '"%:p"', '--', '-'],
		\ 'stdin': 1,
		\ }
let g:neoformat_enabled_lua = ['stylua']

let g:neoformat_try_formatprg = 1
let g:neoformat_only_msg_on_error = 1
]]
