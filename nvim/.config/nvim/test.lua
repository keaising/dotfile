-- DO NOT change the paths and don't remove the colorscheme
local root = vim.fn.fnamemodify("./.repro", ":p")

-- set stdpaths to use .repro
for _, name in ipairs({ "config", "data", "state", "cache" }) do
  vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- bootstrap lazy
local lazypath = root .. "/plugins/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "--single-branch",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

-- install plugins
vim.keymap.set('n', '<Leader>e', '<Plug>(x-file-explorer)', { silent = true })
local M = {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v2.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "kyazdani42/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    "plenary.nvim",
    'nvim-web-devicons',
    'nui.nvim',
  },
  keys = {
    { "<C-n>", "<cmd>Neotree toggle<CR>",  mode = "n", silent = true },
    { "<C-b>", "<cmd>Neotree buffers<CR>", mode = "n", silent = true },
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        hijack_netrw_behavior = "open_default"
      }
    })
  end
}
local plugins = {
  M
}
require("lazy").setup(plugins, {
  root = root .. "/plugins",
})
