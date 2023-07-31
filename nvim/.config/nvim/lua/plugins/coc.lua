return {
    "neoclide/coc.nvim",
    branch = "release",
    config = function()
        -- Some servers have issues with backup files, see #649
        vim.opt.backup = false
        vim.opt.writebackup = false

        -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
        -- delays and poor user experience
        vim.opt.updatetime = 300

        local keyset = vim.keymap.set
        -- Autocomplete
        function _G.check_back_space()
            local col = vim.fn.col(".") - 1
            return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
        end

        -- Use Tab for trigger completion with characters ahead and navigate
        -- NOTE: There's always a completion item selected by default, you may want to enable
        -- no select by setting `"suggest.noselect": true` in your configuration file

        -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
        -- other plugins before putting this into your config
        local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
        keyset(
            "i",
            "<TAB>",
            -- 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
            [[ coc#pum#visible() ? coc#_select_confirm() : coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" : CheckBackspace() ? "\<TAB>" : coc#refresh() ]],
            opts
        )
        keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
        -- Make <CR> to accept selected completion item or notify coc.nvim to format
        -- <C-g>u breaks current undo, please make your own choice
        keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
        -- Use <c-j> to trigger snippets
        keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")

        -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
        vim.api.nvim_create_augroup("CocGroup", {})
        vim.api.nvim_create_autocmd("CursorHold", {
            group = "CocGroup",
            command = "silent call CocActionAsync('highlight')",
            desc = "Highlight symbol under cursor on CursorHold",
        })

        -- Update signature help on jump placeholder
        vim.api.nvim_create_autocmd("User", {

            group = "CocGroup",
            pattern = "CocJumpPlaceholder",
            command = "call CocActionAsync('showSignatureHelp')",
            desc = "Update signature help on jump placeholder",
        })

        -- Apply codeAction to the selected region
        -- Example: `<leader>aap` for current paragraph
        local opts2 = { silent = true, nowait = true }
        keyset("x", "<leader>c", "<Plug>(coc-codeaction-selected)", opts2)
        keyset("n", "<leader>c", "<Plug>(coc-codeaction-selected)", opts2)

        -- Remap keys for apply code actions at the cursor position.
        keyset("n", "<leader>ca", "<Plug>(coc-codeaction-cursor)", opts2)
        -- Remap keys for apply source code actions for current file.
        keyset("n", "<leader>cl", "<Plug>(coc-codeaction-line)", opts2)

        -- Add `:Format` command to format current buffer
        vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})
    end,
}
