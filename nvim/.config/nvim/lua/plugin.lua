return function(packer)
    packer {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}},
        config = function()
            vim.g.NERDSpaceDelims = 1

            require("telescope").setup({
                defaults = {
                    vimgrep_arguments = {'rg', "--color=never", "--no-heading", "--with-filename", "--line-number",
                                         "--column", '--hidden', '--smart-case'},
                    file_ignore_patterns = {".git/", "node_modules"},
                    sorting_strategy = 'ascending',
                    mappings = {
                        i = {
                            ["<esc>"] = require("telescope.actions").close
                        }
                    },
                    layout_strategy = "cursor"
                },
                pickers = {
                    find_files = {
                        -- hidden = true,
                        -- short_path = true,
                        -- find_command = {'fd', '--hidden', "--type", "f", "--strip-cwd-prefix", '--exec-batch ls -l'}
                        -- `sort` is not supported by fd, so replace fd with rg
                        find_command = {'rg', '--sort=path', '--files', "--color=never", "--no-heading",
                                        "--with-filename", "--line-number", "--column", '--hidden', '--smart-case'}
                    }
                }
            })

            local util = require('util')
            util.noremap('n', '<leader>ss', ':Telescope find_files<CR>')
            util.noremap('n', '<leader>fg', ':Telescope live_grep<CR>')
            util.noremap('n', '<leader>fb', ':Telescope buffers<CR>')
            util.noremap('n', '<leader>fh', ':Telescope help_tags<CR>')

        end
    }
end

