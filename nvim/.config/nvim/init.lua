local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	-- bootstrap lazy.nvim
	-- stylua: ignore
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

vim.cmd("source ~/.config/nvim/lua/vim-plugins.vim")
vim.cmd("source ~/.config/nvim/lua/keymaps.vim")

require("lazy").setup("plugins", {
  change_detection = {
    enabled = true,
    notify = false,
  },
})

vim.cmd("source ~/.config/nvim/lua/options.vim")
