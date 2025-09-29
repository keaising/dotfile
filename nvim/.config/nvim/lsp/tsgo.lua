local function tsgo_on_attach(_, bufnr)
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    local fzf = require("fzf-lua")
    local k = vim.keymap.set
    local go_to_definition = function()
        fzf.lsp_definitions({
            jump1 = true,
            ignore_current_line = true,
            multiline = 2,
        })
    end
    k("n", "<m-b>", ":lua vim.lsp.buf.definition()<CR>", bufopts)
    -- k("n", "<m-b>", go_to_definition, bufopts)
    k("n", "gd", go_to_definition, bufopts)
    k("n", "gi", function()
        fzf.lsp_implementations({
            jump1 = true,
            ignore_current_line = true,
            show_line = false,

            multiline = 2,
        })
    end, bufopts)
    k("n", "<m-k>", function()
        return ":IncRename " .. vim.fn.expand("<cword>")
    end, { expr = true, noremap = true, silent = true, buffer = bufnr })
    -- k("n", "<m-.>", function()
    --     fzf.lsp_code_actions({ previewer = false })
    -- end, bufopts)
    -- k("n", "<leader>ca", function()
    --     fzf.lsp_code_actions({ previewer = false })
    -- end, bufopts)
    -- k("n", "gh", "<cmd>lua require('pretty_hover').hover()<CR>", bufopts)
    -- k("n", "K", "<cmd>lua require('pretty_hover').hover()<CR>", bufopts)
    k("n", "`", vim.diagnostic.open_float, bufopts)
    k("n", "gr", function()
        fzf.lsp_references({
            jump1 = true,
            ignore_current_line = true,
            include_current_line = false,
            multiline = 2,
        })
    end, bufopts)
    k("n", "<leader>ls", fzf.lsp_document_symbols, bufopts)
    k("n", "<m-j>", function()
        vim.diagnostic.jump({
            count = 1,
            float = true,
            severity = {
                vim.diagnostic.severity.ERROR,
                vim.diagnostic.severity.WARN,
            },
        })
    end, bufopts)
end

---@type vim.lsp.Config
return {
    cmd = { "tsgo", "--lsp", "--stdio" },
    on_attach = function(client, bufnr)
        client.server_capabilities.hoverProvider = nil
        tsgo_on_attach()
    end,
}
