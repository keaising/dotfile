return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
            {
                "<m-m>",
                "<cmd>ToggleTerm<CR>",
                desc = "Toggle terminal",
            },
        },
        config = function()
            require("toggleterm").setup({
                size = 0.95,
                direction = "float",
                float_opts = {
                    width = function()
                        return math.floor(vim.o.columns * 0.95)
                    end,
                    height = function()
                        return math.floor(vim.o.lines * 0.95)
                    end,
                },
            })
            local terms = require("toggleterm.terminal").get_all
            local function cycle(direction)
                local all = terms(false)
                if #all == 0 then
                    return
                end
                local current = 0
                for i, t in ipairs(all) do
                    if t:is_displayed() then
                        current = i
                        break
                    end
                end
                local next = (current + direction - 1) % #all + 1
                all[next]:open()
            end
            vim.keymap.set("t", "<m-Left>", function()
                cycle(-1)
            end, { silent = true })
            vim.keymap.set("t", "<m-Right>", function()
                cycle(1)
            end, { silent = true })
        end,
    },
    {
        "junegunn/vim-easy-align",
        lazy = false,
    },
    "kshenoy/vim-signature", -- 用于在侧边符号栏显示 marks （ma-mz 记录的位置）
    "tpope/vim-abolish", -- crs/crm/crc
    "preservim/nerdcommenter",
    "tpope/vim-repeat",
    "matze/vim-move",
}
